import 'dart:ffi';
import 'dart:math';

import 'package:gc_wizard/utils/common_utils.dart';
import 'package:image/image.dart' as Image;
import 'dart:typed_data';

import 'image_processing.dart';

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

Uint32List texturePixels;
Uint8List depthBytes;

Uint8List Generate(Uint8List image1, Uint8List image2) {
  var bInterpolateDepthmap = true;
  var oversample = 2;
  fieldDepth = 0.33333;
  separation = 128;


  var bmTexture = Image.decodeImage(image1);
  var bmDepthMap = Image.decodeImage(image2);

  var resolutionX = bmTexture.width;
  var resolutionY = bmTexture.height;
  textureWidth = separation;
  textureHeight = ((separation * bmTexture.height)/ bmTexture.width).toInt();

  // Cache some intermediaries
  lineWidth = resolutionX;
  rows = resolutionY;
  depthWidth = lineWidth;
  depthScale = oversample;
  midpoint = (lineWidth / 2).toInt();

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

  // // Convert texture to RGB24 and scale it to fit the separation (preserving ratio but doubling width for HQ mode)
  // bmTexture = texture.GetToScaleAndFormat(textureWidth, textureHeight, PixelFormats.Pbgra32);

  // Resize the depthmap to our target resolution
  // bmDepthMap = depthmap.GetToScale(depthWidth, resolutionY);

  // Create a great big 2D array to hold the bytes - wasteful but convenient
  pixels = Uint32List(lineWidth * rows);

  // Copy the texture data into a buffer
  // texturePixels = Uint32List((textureWidth * textureHeight).toInt());
  texturePixels = bmTexture.getBytes(); //.CopyPixels(new Int32Rect(0, 0, textureWidth, textureHeight), texturePixels, textureWidth * bytesPerPixel, 0);


  // Copy the depthmap data into a buffer
  // depthBytes = Uint8List[depthWidth * rows];
  depthBytes = bmDepthMap.getBytes(); // //bmDepthMap.CopyPixels(new Int32Rect(0, 0, depthWidth, rows), depthBytes, depthWidth, 0);

  // invert and grayscale
  for (var i = 0, len = depthBytes.length; i < len; i += 4) {
    var pixel = RGBPixel(depthBytes[i].toDouble(), depthBytes[i + 1].toDouble(), depthBytes[i + 2].toDouble());

    pixel = invert(pixel);
    pixel = grayscale(pixel);

    depthBytes[i] = pixel.red.round().clamp(0, 255);
    depthBytes[i + 1] = pixel.green.round().clamp(0, 255);
    depthBytes[i + 2] = pixel.blue.round().clamp(0, 255);
  }

  // Can mock up a progress indicator
  // GeneratedLines = 0;

  initHoroptic();

  // Prime candidate for Parallel.For... yes, about doubles the speed of generation on my Quad-Core
  for (int y = 0; y < rows; y++) {
    DoLineHoroptic(y);
    // if (y > GeneratedLines)
    // {
    //   GeneratedLines = y;
    // }
  }



  // if (abort)
  // {
  //   return null;
  // }
  //
  // // Virtual finaliser... not needed for any current algorithms
  // Finalise();
  //
  // // Create a writeable bitmap to dump the stereogram into
  // wbStereogram = new WriteableBitmap(lineWidth, resolutionY, 96.0, 96.0, bmTexture.Format, bmTexture.Palette);
  // wbStereogram.WritePixels(new Int32Rect(0, 0, lineWidth, rows), pixels, lineWidth * bytesPerPixel, 0);
  //
  // BitmapSource bmStereogram = wbStereogram;
  //
  // High quality images need to be scaled back down...
  if (oversample > 1) {
    double over = oversample.toDouble();
    double centre = lineWidth / 2;
    while (over > 1)
    {
      // Scale by steps... could do it in one pass, but quality would depend on what the hardware does?
      double div = min(over, 2.0);
      //                    double div = over;
      ScaleTransform scale = new ScaleTransform(1.0 / div, 1.0, centre, 0);
      bmStereogram = new TransformedBitmap(bmStereogram, scale);
      bmStereogram = img.copyResize(image, height: previewHeight);

      over /= div;
      centre /= div;
    }
  }



  //
  // Stereogram stereogram = new Stereogram(bmStereogram);
  // stereogram.options = this.options;
  // stereogram.Name = String.Format("{0}+{1}+{2}", depthmap.Name, texture.Name, options.algorithm.ToString());
  // stereogram.Milliseconds = timer.ElapsedMilliseconds;
  // return stereogram;
}


List<int> centreOut;

void initHoroptic(){
  // Create an array of offsets which alternate pixels from the center out to the edges
  centreOut = List<int>.filled(lineWidth, 0);
  int offset = midpoint;
  int flip = -1;
  for (int i = 0; i < lineWidth; i++) {
    centreOut[ i ] = offset;
    offset += ((i + 1) * flip);
    flip = -flip;
  }
}

void DoLineHoroptic( int y ) {
  // Set up a constraints buffer with each pixel initially constrained to equal itself (probably slower than a for loop but easier to step over :p)
  // And convert depths to floats normalised 0..1

  var constraints = List<int>.filled(lineWidth, 0);
  var depthLine = List<double>.filled(lineWidth, 0);
  var max_depth = 0.0;

  for (int i = 0; i < lineWidth; i++) {
    constraints[i] = i;
    depthLine[i] = GetDepthFloat(i, y);
  }

  // Process the line updating any constrained pixels
  for (int ii = 0; ii < lineWidth; ii++) {
    // Work from centre out
    int i = centreOut[ ii ];

    // Calculate Z value of the horopter at this x,y. w.r.t its centre.  20 * separation is approximation of distance to viewer's eyes
    double ZH = sqrt(SquareOf(20 * separation) - SquareOf(i - midpoint) );

    // Scale to the range [0,1] and adjust to displacement from the far plane
    ZH = 1.0 - (ZH / ( 20 * separation ) );

    // Separation of pixels on image plane for this point
    // Note - divide ZH by FieldDepth as the horopter is independant
    // of field depth, but sep macro is not.
    int s = round(sep(depthLine[i] - ( ZH/ fieldDepth))).toInt();

    int left = (i - ( s/ 2 )).toInt();           // The pixel on the image plane for the left eye
    int right = left + s;           // And for the right eye

    if ((0 <= left ) && ( right < lineWidth ) ) {                    // If both points lie within the image bounds ...
      // Decide whether we want to constrain the left or right pixel
      // Want to avoid constraint loops, so always constrain outermost pixel to innermost
      // Should depend if one or the other is already constrained I suppose
      int constrainee = Outermost(left, right, midpoint);
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
    SetStereoPixel(i, y, GetTexturePixel(pix, y));
  }
}

double GetDepthFloat(int x, int y) {
  return (depthBytes[((y * depthWidth) + (x/ depthScale)).toInt()])/ 255;
}

// Just for readability
int SquareOf(int x) {
  return x * x;
}

/// <summary>
/// Helper to calculate stereo separation in pixels of a point at depth Z
/// </summary>
/// <param name="Z"></param>
/// <returns></returns>
double sep( double Z ) {
  if (Z < 0.0) Z = 0.0;
  if (Z > 1.0) Z = 1.0;
  return ((1 - fieldDepth * Z) * (2 * separation)/ (2 - fieldDepth * Z));
}

// Return which of two values is furthest from a mid-point (or indeed any point)
int Outermost( int a, int b, int midpoint ) {
  return ((midpoint - a).abs() > (midpoint - b).abs()) ? a : b;
}

int GetTexturePixel(int x, int y) {
  int tp = (((y % textureHeight ) * textureWidth) + ((x + midpoint) % textureWidth));
  return texturePixels[tp];
}

SetStereoPixel(int x, int y, int pixel) {
  int sp = ((y * lineWidth ) + x);
  pixels[sp] = pixel;
}

