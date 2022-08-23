// source encode: https://github.com/machinewrapped/StereogrammerOS

import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:image/image.dart' as Image;
import 'image_processing.dart';

enum TextureType {
  GREYDOTS,
  COLOURDOTS,
  BITMAP
}

double fieldDepth;
int separation;
int lineWidth;
int rows;
int depthWidth;
int depthScale;
int midpoint;
int textureWidth;
int textureHeight;
Uint32List pixels;

Uint8List texturePixels;
Uint8List depthBytes;

Future<Uint8List> generateImageAsync(dynamic jobData) async {
  if (jobData == null) return null;

  Uint8List hiddenImage = jobData.parameters.item1;
  Uint8List textureImage = jobData.parameters.item2;
  TextureType textureType = jobData.parameters.item3;

  var outputImage = generateImage(hiddenImage, textureImage, textureType);

  if (jobData.sendAsyncPort != null) jobData.sendAsyncPort.send(outputImage);

  return Future.value(outputImage);
}

Uint8List generateImage(Uint8List hiddenDataImage, Uint8List textureImage, TextureType textureType, {SendPort sendAsyncPort}) {
  var bInterpolateDepthmap = true;
  var oversample = 2;
  fieldDepth = 0.33333;
  separation = 128;

  if ((hiddenDataImage == null) | ((textureType == TextureType.BITMAP) && (textureImage == null)))
    return null;


  var depthmap = Image.decodeImage(hiddenDataImage);
  Image.Image texture;
  var resolutionX = depthmap.width;
  var resolutionY = depthmap.height;

  if ((textureType == TextureType.BITMAP) || ((textureType == null) && (textureImage != null)))
    texture= Image.decodeImage(textureImage);
  else if (textureType == TextureType.GREYDOTS)
    texture = _generateGrayDots(separation, resolutionY);
  else
    texture = _generateColoredDots(separation, resolutionY);

  if (hiddenDataImage == null || textureImage== null)
    return null;


  textureWidth = separation;
  textureHeight = ((separation * texture.height)/ texture.width).toInt();

  // Cache some intermediaries
  lineWidth = resolutionX;
  rows = resolutionY;
  depthWidth = lineWidth;
  depthScale = oversample;

  fieldDepth = fieldDepth.clamp(0, 1);

  // Apply oversampling factor to relevant settings
  if (oversample > 1) {
    separation *= oversample;
    lineWidth *= oversample;
    textureWidth *= oversample;

    if (bInterpolateDepthmap ) {
      depthWidth *= oversample;
      depthScale = 1;
    }
  }
  midpoint = (lineWidth/ 2).toInt();

  // Convert texture to RGB24 and scale it to fit the separation (preserving ratio but doubling width for HQ mode)
  var bmTexture = Image.copyResize(texture, width: textureWidth, height: textureHeight);

  // Resize the depthmap to our target resolution
  var bmDepthMap = Image.copyResize(depthmap, width: depthWidth, height: resolutionY);

  // Create a great big 2D array to hold the bytes - wasteful but convenient
  pixels = Uint32List(lineWidth * rows);

  // Copy the texture data into a buffer
  texturePixels = bmTexture.getBytes();

  // invert and grayscale
  bmDepthMap = Image.grayscale(bmDepthMap);
  bmDepthMap = Image.invert(bmDepthMap);
  // Copy the depthmap data into a buffer
  depthBytes = bmDepthMap.getBytes();

  // progress indicator
  var generatedLines = 0;
  var _progressStep = max(rows ~/ 100, 1); // 100 steps

  if (sendAsyncPort != null)
    sendAsyncPort.send({'progress': 0.0});

  initHoroptic();

  for (int y = 0; y < rows; y++) {
    _doLineHoroptic(y);

    if  (y % _progressStep == 0)
      print((y/ rows)*100);


    if (sendAsyncPort != null && (generatedLines % _progressStep == 0))
       sendAsyncPort.send({'progress': generatedLines/ y});
  }

  // BitmapSource bmStereogram = wbStereogram;
  var bmStereogram = Image.Image.fromBytes(lineWidth, rows, pixels.buffer.asUint8List());

  // High quality images need to be scaled back down...
  if (oversample > 1) {
    bmStereogram = Image.copyResize(bmStereogram, width: resolutionX, height: resolutionY);
  }



  //
  // Stereogram stereogram = new Stereogram(bmStereogram);
  // stereogram.options = this.options;
  // stereogram.Name = String.Format("{0}+{1}+{2}", depthmap.Name, texture.Name, options.algorithm.ToString());
  // stereogram.Milliseconds = timer.ElapsedMilliseconds;
  // return stereogram;

  return encodeTrimmedPng(bmStereogram);
}


List<int> centreOut;

void initHoroptic(){
  // Create an array of offsets which alternate pixels from the center out to the edges
  centreOut = List<int>.filled(lineWidth, 0);
  int offset = midpoint;
  int flip = -1;
  for (int i = 0; i < lineWidth; i++) {
    centreOut[i] = offset;
    offset += ((i + 1) * flip);
    flip = -flip;
  }
}

void _doLineHoroptic(int y) {
  // Set up a constraints buffer with each pixel initially constrained to equal itself (probably slower than a for loop but easier to step over :p)
  // And convert depths to floats normalised 0..1

  var constraints = List<int>.filled(lineWidth, 0);
  var depthLine = List<double>.filled(lineWidth, 0);
  var max_depth = 0.0;

  for (int i = 0; i < lineWidth; i++) {
    constraints[i] = i;
    depthLine[i] = _getDepthFloat(i, y);
  }

  // Process the line updating any constrained pixels
  for (int ii = 0; ii < lineWidth; ii++) {
    // Work from centre out
    int i = centreOut[ii];

    // Calculate Z value of the horopter at this x,y. w.r.t its centre.  20 * separation is approximation of distance to viewer's eyes
    double zh = sqrt(_squareOf(20 * separation) - _squareOf(i - midpoint));

    // Scale to the range [0,1] and adjust to displacement from the far plane
    zh = 1.0 - (zh/ (20 * separation));

    // Separation of pixels on image plane for this point
    // Note - divide ZH by FieldDepth as the horopter is independant
    // of field depth, but sep macro is not.
    int s = round(_sep(depthLine[i] - (zh/ fieldDepth))).toInt();

    int left = (i - (s/ 2)).toInt();           // The pixel on the image plane for the left eye
    int right = left + s;           // And for the right eye

    if ((0 <= left) && (right < lineWidth)) {                    // If both points lie within the image bounds ...
      // Decide whether we want to constrain the left or right pixel
      // Want to avoid constraint loops, so always constrain outermost pixel to innermost
      // Should depend if one or the other is already constrained I suppose
      int constrainee = _outermost(left, right, midpoint);
      int constrainer = (constrainee == left) ? right : left;

      // Find an unconstrained pixel and constrain ourselves to it
      // Uh-oh, what happens if they become constrained to each other?  Constrainee is flagged as unconstrained, I suppose
      while (constraints[constrainer] != constrainer)
        constrainer = constraints[constrainer];

      constraints[constrainee] = constrainer;

      // Points can only be hidden by a point closer to the centre, i.e. one we've already processed
      if (depthLine[i] > max_depth)
        max_depth = depthLine[i];
    }
  }

  // Now actually set the pixels
  for (int i = 0; i < lineWidth; i++) {
    int pix = i;

    // Find an unconstrained pixel
    while (constraints[pix] != pix)
      pix = constraints[pix];

    // And get the RGBs from the tiled texture at that point
    _setStereoPixel(i, y, _getTexturePixel(pix, y));
  }
}

double _getDepthFloat(int x, int y) {
  return (depthBytes[((y * depthWidth) + (x/ depthScale)).toInt()])/ 255;
}

// Just for readability
int _squareOf(int x) {
  return x * x;
}

/// <summary>
/// Helper to calculate stereo separation in pixels of a point at depth Z
/// </summary>
/// <param name="Z"></param>
/// <returns></returns>
double _sep(double z) {
  z = z.clamp(0.0, 1.0);
  return ((1 - fieldDepth * z) * (2 * separation)/ (2 - fieldDepth * z));
}

// Return which of two values is furthest from a mid-point (or indeed any point)
int _outermost(int a, int b, int midpoint) {
  return ((midpoint - a).abs() > (midpoint - b).abs()) ? a : b;
}

RGBPixel _getTexturePixel(int x, int y) {
  int tp = (((y % textureHeight) * textureWidth) + ((x + midpoint) % textureWidth));
  return RGBPixel.getPixel(texturePixels, tp * 4);
}

_setStereoPixel(int x, int y, RGBPixel pixel) {
  int sp = ((y * lineWidth) + x);
  pixels[sp] = pixel.color();

}

Image.Image _generateColoredDots(int resX, int resY) {
  Random random = new Random();
  var pixels = Uint8List(resX * resY * 4);

  for (int i = 0; i < pixels.length; i++)
    pixels[i] = random.nextInt(256);

  return Image.Image.fromBytes(resX, resY, pixels);
}

Image.Image _generateGrayDots(int resX, int resY) {
  var image = _generateColoredDots(resX, resY);
  return Image.grayscale(image);
}

