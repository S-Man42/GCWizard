import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:image/image.dart' as Image;

class _SymbolRow {
  ui.Rect size;

  _SymbolRow(ui.Rect size) {
    this.size = size;
  }
}

class _Symbol {
  ui.Offset refPoint;
  Image.Image bmp; // bitmap;
  int hash;
  _SymbolRow row;
  _SymbolGroup symbolGroup;

  _Symbol(ui.Offset refPoint, Image.Image bitmap, _SymbolRow row) {
    this.refPoint = refPoint;
    this.bmp = bitmap;
    this.row = row;
  }
}

class _SymbolGroup {
  String text;
  var symbolList = <_Symbol>[];
}

List<_SymbolGroup> splitAndGroupSymbols(Image.Image bmp, int blackLevel, int similarityLevel, {int gap = 1}) {
  var symbols = <_Symbol>[];
  blackLevel = (blackLevel * 255/100).toInt();

  var lines = _splitToLines(bmp, blackLevel);
  lines.forEach((line) {
    var lineSymbols = _splitLineToSymbols(line, gap, blackLevel);
    symbols.addAll(lineSymbols);
  });

  return _groupSymbols(symbols, similarityLevel.toDouble());
}

//region Merge Data
Image.Image mergeSymbolData(Image.Image image, List<_SymbolGroup> symbolGroups) {
  var bmp = Image.Image(image.width, image.height);

  Image.drawRect(bmp, 0, 0, bmp.width, bmp.height, Colors.white.value);

  symbolGroups.forEach((symbolGroup) {
    if ((symbolGroup.text == null) || (symbolGroup.text == '') ) {
      symbolGroup.symbolList.forEach((symbol) {
        Image.drawImage(bmp, symbol.bmp, dstX: symbol.refPoint.dx.toInt(), dstY: symbol.refPoint.dy.toInt() );
      });
    } else {
      var font = Image.arial_14;
      var color = Colors.red.value;
      symbolGroup.symbolList.forEach((symbol) {
        Image.drawString(bmp, font, symbol.refPoint.dx.toInt(), symbol.row.size.bottom.toInt(), symbolGroup.text, color: color);
      });
    }
  });

  return bmp;
}
//endregion

//region group symbols
List<_SymbolGroup> _groupSymbols(List<_Symbol> symbols, double similarityLevel) {
  var groups = <_SymbolGroup>[];
  var imageHashing = new _ImageHashing();

  for (int i = 0; i < symbols.length - 1; i++)
    symbols[i].hash = imageHashing.AverageHash(symbols[i].bmp);

  for (int i = 0; i < symbols.length - 1; i++) {
    double maxPercent = 0;
    int maxPercentIndex = 0;

    _Symbol symbol1 = symbols[i];

    for (int x = 0; x < i; x++) {
      var similarity = imageHashing.Similarity(
          symbols[i].hash, symbols[x].hash);
      if (similarity > maxPercent) {
        maxPercent = similarity;
        maxPercentIndex = x;
      }
    }

    if ((maxPercent < similarityLevel) | ((maxPercentIndex > i))) {
      var group = new _SymbolGroup();
      groups.add(group);
      groups[groups.length - 1].symbolList.add(symbol1);
      symbol1.symbolGroup = group;
    } else {
      var image2 = symbols[maxPercentIndex];
      for (_SymbolGroup group in groups) {
        if (group.symbolList.contains(image2)) {
          group.symbolList.add(symbol1);
          symbol1.symbolGroup = group;
          break;
        }
      };
    }
  }
  return groups;
}

Image.Image buildSymbolGroupView(_SymbolGroup symbolGroup, {int height = 0}) {
  var targetRatio = 3;
  bool cancel = false;
  var cancelCounter = 0;
  ui.Offset size;
  ui.Offset rowSize;
  var maxWidth = 999999999.0;

  do {
    size = new ui.Offset(0, 0);
    rowSize = new ui.Offset(0, 0);
    symbolGroup.symbolList.forEach((symbol) {
      if (rowSize.dx + symbol.bmp.width > maxWidth) {
        size = size.translate(max(rowSize.dx, size.dx) - size.dx, rowSize.dy);
        rowSize = new ui.Offset(0 ,0);
      }

      rowSize = rowSize.translate(
          symbol.bmp.width.toDouble(),
          max(rowSize.dy, symbol.bmp.height.toDouble()) - rowSize.dy
      );
    });
    size = size.translate(max(rowSize.dx, size.dx) - size.dx, rowSize.dy);

    var ratio = size.dx / size.dy;
    if (ratio > targetRatio && symbolGroup.symbolList.length > 4)
      maxWidth = (size.dx * (cancelCounter == 0 ? 1.0 / 2.0 : 2.0 / 3.0));
    else
      cancel = true;

    cancelCounter++;
  } while (!cancel && (cancelCounter < 6));



  var image = Image.Image(size.dx.toInt(), size.dy.toInt());
  var offset = ui.Offset(0, 0);

  var rowHeight = 0;
  symbolGroup.symbolList.forEach((symbol) {
    if (offset.dx + symbol.bmp.width > size.dx) {
      offset.translate(-offset.dx, rowHeight.toDouble());
      rowHeight = 0;
    }
    Image.drawImage(image, symbol.bmp, dstX: offset.dx.toInt(), dstY: offset.dy.toInt());
    offset = offset.translate(symbol.bmp.width.toDouble(), 0);
    rowHeight = max(rowHeight, symbol.bmp.height);
  });

  // if (height > 0) {
  //   height *= rowCount;
  //   Image.GetThumbnailImageAbort myCallback = new Image.GetThumbnailImageAbort(ThumbnailCallback);
  //   image = image.GetThumbnailImage((int)(image.Width * (double)height / image.Height), height, myCallback, IntPtr.Zero);
  // }
  return image;
}


//endregion

//region clip symbols

List<_Symbol> _splitLineToSymbols(_Symbol line, int gap, int blackLevel) {
  var symbols = <_Symbol>[];
  var emptyColumnIndex = <int>[];

  for (int x = 0; x < line.bmp.width - 1; x++) {
    var emptyColumn = true;
    for (int y = 0; y < line.bmp.height; y++) {
      var pixel = line.bmp.getPixel(x, y);

      if (_blackPixel(pixel, blackLevel)) {
        emptyColumn = false;
        break;
      }
    }
    if (emptyColumn) emptyColumnIndex.add(x);
  }

  if (emptyColumnIndex.length > 0) {
    emptyColumnIndex = _removeGapColumns(emptyColumnIndex, gap);

    if (emptyColumnIndex[0] != 0)
      _cutSymbol(line, 0, emptyColumnIndex[0] - 1, symbols, blackLevel);

    for (int i = 1; i < emptyColumnIndex.length - 1; i++) {
      if (emptyColumnIndex[i - 1] != emptyColumnIndex[i] - 1)
        _cutSymbol(line, emptyColumnIndex[i - 1], emptyColumnIndex[i], symbols, blackLevel);
    }

    if ((emptyColumnIndex[emptyColumnIndex.length - 1] != line.bmp.width - 1) &
      (emptyColumnIndex[emptyColumnIndex.length - 1] != 0))
      _cutSymbol(line, emptyColumnIndex[emptyColumnIndex.length - 1] + 1, line.bmp.width - 1, symbols, blackLevel);
  }

  return symbols;
}

List<int> _removeGapColumns(List<int> emptyColumnIndex, int gap) {
  if (gap > 1) {
    for (int i = emptyColumnIndex.length - 1 - gap; i > 0; i--) {
      // previus column not empty ?
      if (emptyColumnIndex[i - 1] != emptyColumnIndex[i] - 1) {
        var emtyColumnsCount = _countEmptyColumns(emptyColumnIndex, i);

        if (emtyColumnsCount <= gap)
          for (int x = emtyColumnsCount - 1; x >= 0; x--)
            emptyColumnIndex.removeAt(i + x);
      }
    }
  }
  return emptyColumnIndex;
}

int _countEmptyColumns(List<int> emptyColumnIndex, int startIndex) {
  var counter = 1;
  for (int i = startIndex; i < emptyColumnIndex.length - 1; i++) {
    if (emptyColumnIndex[i] == emptyColumnIndex[i + 1] - 1)
      counter++;
    else
      break;
  }
  return counter;
}

ui.Rect _cutSymbol(_Symbol line, int startIndex, int endIndex, List<_Symbol> symbols, int blackLevel) {
  var rect = new ui.Rect.fromLTWH(
      startIndex.toDouble(),
      0,
      (endIndex - startIndex).toDouble(),
      line.bmp.height.toDouble());

  if (rect.width > 0) {
    var box = _boundingBox(line.bmp, rect, blackLevel);
    var refPoint = ui.Offset(box.left, box.top);
    refPoint = refPoint.translate(line.refPoint.dx, line.refPoint.dy);
    symbols.add(new _Symbol(refPoint,
        Image.copyCrop(line.bmp,
            box.left.toInt(),
            box.top.toInt(),
            box.width.toInt(),
            box.height.toInt()),
        line.row));
  }
  return rect;
}

ui.Rect _boundingBox(Image.Image bmp, ui.Rect rect, int blackLevel) {
  var startRow = rect.top.toInt();
  var endRow = rect.bottom.toInt() - 1;

  for (int y = rect.top.toInt(); y <= rect.bottom - 1; y++) {
    if (!_emptyRow(bmp, rect.left.toInt(), rect.right.toInt(), y, blackLevel)) {
      startRow = y;
      break;
    }
  }

  for (int y = rect.bottom.toInt() - 1; y >= rect.top; y--) {
    if (!_emptyRow(bmp, rect.left.toInt(), rect.right.toInt(), y, blackLevel)) {
      endRow = y + 1;
      break;
    }
  }
  return ui.Rect.fromLTWH(rect.left, startRow.toDouble(), rect.width, (endRow - startRow).toDouble());
}

List<_Symbol> _splitToLines(Image.Image bmp, int blackLevel) {
  var lines = <_Symbol>[];
  var emptyLineIndex = <int>[];

  // search empty lines
  for (int y = 0; y < bmp.height; y++)
    if (_emptyRow(bmp, 0, bmp.width - 1, y, blackLevel)) emptyLineIndex.add(y);

  // split lines
  if (emptyLineIndex.length > 0)
  {
    if (emptyLineIndex[0] != 0)
      _cutLine(bmp, 0, emptyLineIndex[0] - 1, lines);

    for (int i = 1; i < emptyLineIndex.length; i++)
    {
      if (emptyLineIndex[i - 1] != emptyLineIndex[i] - 1)
        _cutLine(bmp, emptyLineIndex[i - 1] + 1, emptyLineIndex[i] - 1, lines);
    }

    if ((emptyLineIndex[emptyLineIndex.length - 1] != bmp.height - 1) & (emptyLineIndex[emptyLineIndex.length - 1] != 0))
      _cutLine(bmp, emptyLineIndex[emptyLineIndex.length - 1] + 1, bmp.height - 1, lines);
  }

  return lines;
}

bool _emptyRow(Image.Image bmp, int startColumn, int endColumn, int row, int blackLevel) {
  for (int x = startColumn; x <= endColumn; x++) {
    var pixel = bmp.getPixel(x, row);
    if (_blackPixel(pixel, blackLevel)) return false;
  }
  return true;
}

ui.Rect _cutLine(Image.Image bmp, int startIndex, int endIndex, List<_Symbol> lines) {
  var rect = new ui.Rect.fromLTWH(0, startIndex.toDouble(), bmp.width.toDouble(), (endIndex - startIndex).toDouble());

  if (rect.height > 0)
    lines.add(new _Symbol(rect.topLeft,
        Image.copyCrop(bmp,
            rect.top.toInt(),
            rect.left.toInt(),
            rect.width.toInt(),
            rect.height.toInt()),
        new _SymbolRow(rect)));

  return rect;
}

bool _blackPixel(int color, int blackLevel) {
  return (Image.getLuminance(color) <= blackLevel);
}

//endregion

/// <summary>
/// Contains a variety of methods useful in generating image hashes for image comparison
/// and recognition.
///
/// Credit for the AverageHash implementation to David Oftedal of the University of Oslo.
/// </summary>
class _ImageHashing {
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
  4,5,5,6,5,6,6,7,5,6,6,7,6,7,7,8]);

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
  int AverageHash(Image.Image image) {
    // Squeeze the image into an 8x8 canvas
    Image.Image squeezed = Image.copyResize(image,width: 8, height: 8,interpolation: Image.Interpolation.nearest);  //,interpolation: Interpol (8, 8, PixelFormat.Format32bppRgb);

    // Reduce colors to 6-bit grayscale and calculate average color value
    var grayscale = Uint8List(64);
    int averageValue = 0;
    for (int y = 0; y < 8; y++)
      for (int x = 0; x < 8; x++) {
        int pixel = squeezed.getPixel(x, y); //..ToArgb();
        int gray = (pixel & 0x00ff0000) >> 16;
        gray += (pixel & 0x0000ff00) >> 8;
        gray += (pixel & 0x000000ff);
        gray = (gray / 12).toInt();

        grayscale[x + (y * 8)] = gray;
        averageValue += gray;
      }
    averageValue = (averageValue / 64).toInt();

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
  double SimilarityImage(Image.Image image1, Image.Image image2) {
    int hash1 = AverageHash(image1);
    int hash2 = AverageHash(image2);
    return Similarity(hash1, hash2);
  }
}
