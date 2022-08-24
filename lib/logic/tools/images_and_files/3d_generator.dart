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

double _fieldDepth;
int _separation;
int _lineWidth;
int _rows;
int _depthWidth;
int _depthScale;
int _midpoint;
int _textureWidth;
int _textureHeight;
Uint32List _pixels;
Uint8List _texturePixels;
Uint8List _depthBytes;

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
  Image.Image texture;

  _fieldDepth = 0.33333;
  _separation = 128;

  if ((hiddenDataImage == null) | ((textureType == TextureType.BITMAP) && (textureImage == null)))
    return null;

  var depthmap = Image.decodeImage(hiddenDataImage);
  var resolutionX = depthmap.width;
  var resolutionY = depthmap.height;

  if ((textureType == TextureType.BITMAP) || ((textureType == null) && (textureImage != null)))
    texture= Image.decodeImage(textureImage);
  else if (textureType == TextureType.GREYDOTS)
    texture = _generateGrayDotsTexture(_separation, resolutionY);
  else
    texture = _generateColoredDotsTexture(_separation, resolutionY);

  if (hiddenDataImage == null || textureImage== null)
    return null;

  _textureWidth = _separation;
  _textureHeight = ((_separation * texture.height)/ texture.width).toInt();

  // Cache some intermediaries
  _lineWidth = resolutionX;
  _rows = resolutionY;
  _depthWidth = _lineWidth;
  _depthScale = oversample;

  _fieldDepth = _fieldDepth.clamp(0, 1);

  // Apply oversampling factor to relevant settings
  if (oversample > 1) {
    _separation *= oversample;
    _lineWidth *= oversample;
    _textureWidth *= oversample;

    if (bInterpolateDepthmap) {
      _depthWidth *= oversample;
      _depthScale = 1;
    }
  }
  _midpoint = (_lineWidth/ 2).toInt();

  // Convert texture to RGB24 and scale it to fit the separation (preserving ratio but doubling width for HQ mode)
  var bmTexture = Image.copyResize(texture, width: _textureWidth, height: _textureHeight);

  // Resize the depthmap to our target resolution
  var bmDepthMap = Image.copyResize(depthmap, width: _depthWidth, height: resolutionY);

  // Create a great big 2D array to hold the bytes - wasteful but convenient
  _pixels = Uint32List(_lineWidth * _rows);

  // Copy the texture data into a buffer
  _texturePixels = bmTexture.getBytes(format: Image.Format.rgba);

  // grayscale and invert
  bmDepthMap = Image.grayscale(bmDepthMap);
  bmDepthMap = Image.invert(bmDepthMap);
  // Copy the depthmap data into a buffer
  _depthBytes = bmDepthMap.getBytes(format: Image.Format.rgba);

  // progress indicator
  var generatedLines = 0;
  var _progressStep = max(_rows ~/ 100, 1); // 100 steps

  if (sendAsyncPort != null)
    sendAsyncPort.send({'progress': 0.0});

  initHoroptic();

  for (int y = 0; y < _rows; y++) {
    _doLineHoroptic(y);

    if (sendAsyncPort != null && (generatedLines % _progressStep == 0))
       sendAsyncPort.send({'progress': y/ _rows});
  }

  var bmStereogram = Image.Image.fromBytes(_lineWidth, _rows, _pixels.buffer.asUint8List(),
                                          format: Image.Format.rgb, channels: Image.Channels.rgb);

  // High quality images need to be scaled back down...
  if (oversample > 1) {
    bmStereogram = Image.copyResize(bmStereogram, width: resolutionX, height: resolutionY);
  }

  return encodeTrimmedPng(bmStereogram);
}


List<int> centreOut;

void initHoroptic(){
  // Create an array of offsets which alternate pixels from the center out to the edges
  centreOut = List<int>.filled(_lineWidth, 0);
  int offset = _midpoint;
  int flip = -1;
  for (int i = 0; i < _lineWidth; i++) {
    centreOut[i] = offset;
    offset += ((i + 1) * flip);
    flip = -flip;
  }
}

void _doLineHoroptic(int y) {
  // Set up a constraints buffer with each pixel initially constrained to equal itself (probably slower than a for loop but easier to step over :p)
  // And convert depths to floats normalised 0..1

  var constraints = List<int>.filled(_lineWidth, 0);
  var depthLine = List<double>.filled(_lineWidth, 0);
  var max_depth = 0.0;

  for (int i = 0; i < _lineWidth; i++) {
    constraints[i] = i;
    depthLine[i] = _getDepthFloat(i, y);
  }

  // Process the line updating any constrained pixels
  for (int ii = 0; ii < _lineWidth; ii++) {
    // Work from centre out
    int i = centreOut[ii];

    // Calculate Z value of the horopter at this x,y. w.r.t its centre.  20 * separation is approximation of distance to viewer's eyes
    double zh = sqrt(pow(20 * _separation, 2) - pow(i - _midpoint, 2));

    // Scale to the range [0,1] and adjust to displacement from the far plane
    zh = 1.0 - (zh/ (20 * _separation));

    // Separation of pixels on image plane for this point
    // Note - divide ZH by FieldDepth as the horopter is independant
    // of field depth, but sep macro is not.
    int s = round(_sep(depthLine[i] - (zh/ _fieldDepth))).toInt();

    int left = (i - (s/ 2)).toInt(); // The pixel on the image plane for the left eye
    int right = left + s;           // And for the right eye

    if ((0 <= left) && (right < _lineWidth)) {  // If both points lie within the image bounds ...
      // Decide whether we want to constrain the left or right pixel
      // Want to avoid constraint loops, so always constrain outermost pixel to innermost
      // Should depend if one or the other is already constrained I suppose
      int constrainee = _outermost(left, right, _midpoint);
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
  for (int i = 0; i < _lineWidth; i++) {
    int pix = i;

    // Find an unconstrained pixel
    while (constraints[pix] != pix)
      pix = constraints[pix];

    // And get the RGBs from the tiled texture at that point
    _setStereoPixel(i, y, _getTexturePixel(pix, y));
  }
}

double _getDepthFloat(int x, int y) {
  return (_depthBytes[((y * _depthWidth) + (x/ _depthScale)).toInt()])/ 255;
}

/// Helper to calculate stereo separation in pixels of a point at depth Z
double _sep(double z) {
  z = z.clamp(0.0, 1.0);
  return ((1 - _fieldDepth * z) * (2 * _separation)/ (2 - _fieldDepth * z));
}

/// Return which of two values is furthest from a mid-point (or indeed any point)
int _outermost(int a, int b, int midpoint) {
  return ((midpoint - a).abs() > (midpoint - b).abs()) ? a : b;
}

RGBPixel _getTexturePixel(int x, int y) {
  int tp = ((y % _textureHeight) * _textureWidth) + ((x + _midpoint) % _textureWidth);
  return RGBPixel.getPixel(_texturePixels, tp * 4); // 4 Channels (RGBA)
}

_setStereoPixel(int x, int y, RGBPixel pixel) {
  int sp = ((y * _lineWidth) + x);
  _pixels[sp] = pixel.color();
}

Image.Image _generateColoredDotsTexture(int resX, int resY) {
  Random random = new Random();
  var pixels = Uint8List(resX * resY * 4); // 4 Channels (RGBA)

  for (int i = 0; i < pixels.length; i++)
    pixels[i] = random.nextInt(256);

  return Image.Image.fromBytes(resX, resY, pixels, format: Image.Format.rgba, channels: Image.Channels.rgba);
}

Image.Image _generateGrayDotsTexture(int resX, int resY) {
  var image = _generateColoredDotsTexture(resX, resY);
  return Image.grayscale(image);
}

