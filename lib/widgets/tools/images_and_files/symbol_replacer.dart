import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:image/image.dart' as Image;
import 'package:universal_html/html.dart';

/// <summary>
/// Contains a variety of methods useful in generating image hashes for image comparison
/// and recognition.
///
/// Credit for the AverageHash implementation to David Oftedal of the University of Oslo.
/// </summary>
class _ImageHashing
{
  /// Private constants and utility methods
  /// <summary>
  /// Bitcounts array used for BitCount method (used in Similarity comparisons).
  /// Don't try to read this or understand it, I certainly don't. Credit goes to
  /// David Oftedal of the University of Oslo, Norway for this.
  /// http://folk.uio.no/davidjo/computing.php
  /// </summary>
  final _bitCounts = Uint8List.fromList([
  0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4,1,2,2,3,2,3,3,4,2,3,3,4,3,4,4,5,1,2,2,3,2,3,3,4,
  2,3,3,4,3,4,4,5,2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6,1,2,2,3,2,3,3,4,2,3,3,4,3,4,4,5,
  2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6,2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6,3,4,4,5,4,5,5,6,
  4,5,5,6,5,6,6,7,1,2,2,3,2,3,3,4,2,3,3,4,3,4,4,5,2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6,
  2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6,3,4,4,5,4,5,5,6,4,5,5,6,5,6,6,7,2,3,3,4,3,4,4,5,
  3,4,4,5,4,5,5,6,3,4,4,5,4,5,5,6,4,5,5,6,5,6,6,7,3,4,4,5,4,5,5,6,4,5,5,6,5,6,6,7,
  4,5,5,6,5,6,6,7,5,6,6,7,6,7,7,8
  ]);

  /// <summary>
  /// Counts bits (duh). Utility function for similarity.
  /// I wouldn't try to understand this. I just copy-pasta'd it
  /// from Oftedal's implementation. It works.
  /// </summary>
  /// <param name="num">The hash we are counting.</param>
  /// <returns>The total bit count.</returns>
  int _BitCount(int num) {
    int count = 0;
    for (; num > 0; num >>= 8)
      count += _bitCounts[(num & 0xff)];
    return count;
  }

  /// <summary>
  /// Computes the average hash of an image according to the algorithm given by Dr. Neal Krawetz
  /// on his blog: http://www.hackerfactor.com/blog/index.php?/archives/432-Looks-Like-It.html.
  /// </summary>
  /// <param name="image">The image to hash.</param>
  /// <returns>The hash of the image.</returns>
  int AverageHash(ui.Image image) {
    // Squeeze the image into an 8x8 canvas
    var rect = ui.Rect.fromLTWH(0, 0, 8, 8);
    Image.Image squeezed = Image.Image(rect.width.toInt(), rect.height.toInt());  //(8, 8, PixelFormat.Format32bppRgb);
    final recorder = ui.PictureRecorder();
    ui.Canvas canvas = ui.Canvas(recorder);
    canvas.clipRect(rect);
    //canvas.CompositingQuality = CompositingQuality.HighQuality;
    //canvas.InterpolationMode = InterpolationMode.HighQualityBilinear;
    //canvas.SmoothingMode = SmoothingMode.HighQuality;
    final paint = ui.Paint()
      ..color = Colors.white
      ..style = ui.PaintingStyle.fill;
    canvas.drawImage(image, ui.Offset(0, 0), paint);

    // Reduce colors to 6-bit grayscale and calculate average color value
    var grayscale = Uint8List(64);
    int averageValue = 0;
    for (int y = 0; y < 8; y++)
      for (int x = 0; x < 8; x++) {
        int pixel = squeezed.getPixel(x, y); //..ToArgb();
        int gray = (pixel & 0x00ff0000) >> 16;
        gray += (pixel & 0x0000ff00) >> 8;
        gray += (pixel & 0x000000ff);
        gray = (gray / 12 as int);

        grayscale[x + (y * 8)] = gray;
        averageValue += gray;
      }
    averageValue = (averageValue / 64 as int);

    // Compute the hash: each bit is a pixel
    // 1 = higher than average, 0 = lower than average
    int hash = 0;
    for (int i = 0; i < 64; i++)
      if (grayscale[i] >= averageValue)
        hash |= (1 << (63 - i));

    if (hash < 0) hash = ~hash; //no uint
    return hash;
  }


  /// <summary>
  /// Returns a percentage-based similarity value between the two given hashes. The higher
  /// the percentage, the closer the hashes are to being identical.
  /// </summary>
  /// <param name="hash1">The first hash.</param>
  /// <param name="hash2">The second hash.</param>
  /// <returns>The similarity percentage.</returns>
  double Similarity(int hash1, int hash2) {
    return ((64 - _BitCount(hash1 ^ hash2)) * 100) / 64.0;
  }

  /// <summary>
  /// Returns a percentage-based similarity value between the two given images. The higher
  /// the percentage, the closer the images are to being identical.
  /// </summary>
  /// <param name="image1">The first image.</param>
  /// <param name="image2">The second image.</param>
  /// <returns>The similarity percentage.</returns>
  double SimilarityImage(ui.Image image1, ui.Image image2) {
    int hash1 = AverageHash(image1);
    int hash2 = AverageHash(image2);
    return Similarity(hash1, hash2);
  }
}
