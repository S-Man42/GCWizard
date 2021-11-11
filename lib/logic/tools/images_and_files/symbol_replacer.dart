import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table_data.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:image/image.dart' as Image;


SymbolImage replaceSymbols(Uint8List image,
    int blackLevel,
    double similarityLevel,
    {int gap = 1,
      SymbolImage symbolImage,
      List<Map<String, SymbolData>> compareSymbols,
      double similarityCompareLevel
    }) {
  if (symbolImage == null)
    symbolImage = SymbolImage(image);

  symbolImage.splitAndGroupSymbols(
      (blackLevel * 255/100).toInt(),
      similarityLevel,
      gap: gap,
      compareImages: compareSymbols,
      similarityCompareLevel: similarityCompareLevel
  );

  return symbolImage;
}

class SymbolImage {
  Uint8List _image;
  Image.Image _bmp;
  Image.Image _outputImage;
  Uint8List _outputImageBytes;
  List<Map<String, SymbolData>> _compareSymbols;
  SymbolImage _compareImage;
  double _similarityCompareLevel;

  List<_SymbolRow> lines = [];
  List<_Symbol> symbols = [];
  List<SymbolGroup> symbolGroups = [];

  int _blackLevel;
  double _similarityLevel;
  int _gap;

  SymbolImage(Uint8List image) {
    _image = image;
    _outputImageBytes = image;
  }

  Uint8List getImage() {
    if (_outputImageBytes != null)
      return _outputImageBytes;

    _outputImageBytes = encodeTrimmedPng(_outputImage);
    return _outputImageBytes;
  }

  String getTextOutput() {
    var output = '';
    lines.forEach((line) {
      line.symbols.forEach((symbol) {
        output += symbol.symbolGroup?.text != null ? symbol.symbolGroup.text : '';
      });
      output += '\r\n';
    });
    return output.trim();
  }

  splitAndGroupSymbols(int blackLevel,
      double similarityLevel,
      {int gap = 1,
      List<Map<String, SymbolData>> compareImages,
      double similarityCompareLevel = 80,
      bool groupSymbols = true
      }) {
    if (_image == null) return;
    if (_bmp == null)
      _bmp = Image.decodeImage(_image);
    if (_bmp == null) return;
    if (blackLevel == null) return;
    if (similarityLevel == null) return;

    if (_blackLevel != blackLevel) {
      lines.clear();
      symbols.clear();
      symbolGroups.clear();
    }
    _blackLevel = blackLevel;

    if (_gap != gap) {
      symbols.clear();
      symbolGroups.clear();
    }
    _gap = gap;

    if (_similarityLevel != similarityLevel)
      symbolGroups.clear();
    _similarityLevel = similarityLevel;
    _similarityCompareLevel = similarityCompareLevel;

    if (lines.isEmpty)
      _splitToLines();

    if (symbols.isEmpty)
      lines.forEach((line) {
        line._splitLineToSymbols( gap, _blackLevel);
        symbols.addAll(line.symbols);
      });

    if (symbolGroups.isEmpty && groupSymbols)
      _groupSymbols();

    if (groupSymbols & (compareImages != null) & (_similarityCompareLevel != null)) {
      if (_compareSymbols != compareImages || _compareImage == null) {
        _compareImage = _buildCompareSymbols(compareImages);
      }
      _useCompareSymbols(_compareImage);
      _compareSymbols = compareImages;
    }

    var mergeText = false;
    for (SymbolGroup group in symbolGroups) {
      if (group.text != null || group.text != '') {
        mergeText = true;
        break;
      }
    }

    if (mergeText) {
      _outputImage = _mergeSymbolData();
      _outputImageBytes = null;
    } else {
      _outputImage = _bmp;
      _outputImageBytes = _image;
    }
  }

  SymbolImage _buildCompareSymbols(List<Map<String, SymbolData>> compareImages) {
    var compareSymbolImage = SymbolImage(compareImages.first.values.first.bytes);

    compareImages.forEach((element) {
      element.forEach((text, symbolData) {
        if (symbolData != null && symbolData.bytes != null) {
          var symbolImage = SymbolImage(symbolData.bytes);
          symbolImage.splitAndGroupSymbols(_blackLevel, _similarityLevel, gap: _gap, groupSymbols: false);

          symbolImage.symbols.forEach((element) {
            var symbolGroup = SymbolGroup();
            symbolGroup.symbols = symbolImage.symbols;
            symbolGroup.text = text;
            symbolGroup.symbols.forEach((symbol) {symbol.symbolGroup = symbolGroup; });
            symbolImage.symbols = null;

            compareSymbolImage.symbols.addAll(symbolGroup.symbols);
            compareSymbolImage.symbolGroups.add(symbolGroup);
          });
        }
      });
    });

    return compareSymbolImage;
  }

  _useCompareSymbols(SymbolImage compareSymbolImage) {
    var imageHashing = new ImageHashing();

    for (int i = 0; i < compareSymbolImage.symbols.length; i++)
      compareSymbolImage.symbols[i].hash = imageHashing.AverageHash(compareSymbolImage.symbols[i].bmp);

    for (int i = 0; i < symbolGroups.length; i++) {
      double maxPercent = 0.0;
      _Symbol maxPercentSymbol;

      _Symbol symbol1 = symbolGroups[i].symbols.first;

      for (int x = 0; x < compareSymbolImage.symbols.length; x++) {
        var similarity = imageHashing.Similarity(symbol1.hash, compareSymbolImage.symbols[x].hash);
        if (similarity > maxPercent) {
          maxPercent = similarity;
          maxPercentSymbol = compareSymbolImage.symbols[x];
        }
      }
      if (maxPercent >= _similarityCompareLevel) {
        symbolGroups[i].text = maxPercentSymbol.symbolGroup.text;
        //ToDo wieder raus nur für Test
        //symbolGroups[i].symbols.add(maxPercentSymbol);
      }
    }
  }

  Image.Image _mergeSymbolData() {
    var bmp = Image.Image(_bmp.width, _bmp.height);

    Image.fillRect(bmp, 0, 0, bmp.width, bmp.height, Colors.white.value);

    symbolGroups.forEach((symbolGroup) {
      if ((symbolGroup.text == null) || (symbolGroup.text == '') ) {
        symbolGroup.symbols.forEach((symbol) {
          Image.drawImage(bmp, symbol.bmp, dstX: symbol.refPoint.dx.toInt(), dstY: symbol.refPoint.dy.toInt() );
        });
      } else {
        var font = Image.arial_14;
        var color = Colors.red.value;
        ui.Offset offset;
        symbolGroup.symbols.forEach((symbol) {
          if (symbol.row.size.height < 24) {
            font = Image.arial_14;
            offset = ui.Offset(-3, -7);
          } else if (symbol.row.size.height < 48) {
            font = Image.arial_24;
            offset = ui.Offset(-6, -12);
          } else {
            font = Image.arial_48;
            offset = ui.Offset(-14, -24);
          }
          // Image.drawImage(bmp, symbol.bmp, dstX: symbol.refPoint.dx.toInt(), dstY: symbol.refPoint.dy.toInt() );
          Image.drawString(bmp, font,
              (symbol.refPoint.dx + symbol.bmp.width/2 + offset.dx).toInt(),
              (symbol.row.size.center.dy + offset.dy).toInt(),
              symbolGroup.text,
              color: Colors.indigo.value);
        });
      }
    });

    return bmp;
  }

  _splitToLines() {
    var emptyLineIndex = <int>[];

    // search empty lines
    for (int y = 0; y < _bmp.height; y++)
      if (_emptyRow(_bmp, 0, _bmp.width - 1, y, _blackLevel)) emptyLineIndex.add(y);

    // split lines
    if (emptyLineIndex.length > 0) {
      if (emptyLineIndex.first != 0)
        _cutLine(0, emptyLineIndex.first - 1);

      for (int i = 1; i < emptyLineIndex.length; i++) {
        if (emptyLineIndex[i - 1] != emptyLineIndex[i] - 1)
          _cutLine( emptyLineIndex[i - 1] + 1, emptyLineIndex[i] - 1);
      }

      if ((emptyLineIndex.last != _bmp.height - 1) & (emptyLineIndex.last != 0))
        _cutLine(emptyLineIndex.last + 1, _bmp.height - 1);
    }
  }

  _cutLine(int startIndex, int endIndex) {
    var rect = new ui.Rect.fromLTWH(0, startIndex.toDouble(), _bmp.width.toDouble(), (endIndex - startIndex).toDouble());

    if (rect.height > 0)
      lines.add(_SymbolRow(rect,
          Image.copyCrop(_bmp,
              rect.left.toInt(),
              rect.top.toInt(),
              rect.width.toInt(),
              rect.height.toInt())
      ));
  }

  _groupSymbols() {
    var imageHashing = new ImageHashing();

    for (int i = 0; i < symbols.length; i++)
      symbols[i].hash = imageHashing.AverageHash(symbols[i].bmp);

    for (int i = 0; i < symbols.length; i++) {
      double maxPercent = 0;
      int maxPercentSymbolIndex = 0;

      _Symbol symbol1 = symbols[i];

      for (int x = 0; x < i; x++) {
        var similarity = imageHashing.Similarity(symbol1.hash, symbols[x].hash);
        if (similarity > maxPercent) {
          maxPercent = similarity;
          maxPercentSymbolIndex = x;
        }
      }

      if ((maxPercent < _similarityLevel) | (maxPercentSymbolIndex > i)) {
        var group = new SymbolGroup();
        symbolGroups.add(group);
        symbolGroups[symbolGroups.length - 1].symbols.add(symbol1);
        symbol1.symbolGroup = group;
      } else {
        var image2 = symbols[maxPercentSymbolIndex];
        for (SymbolGroup group in symbolGroups) {
          if (group.symbols.contains(image2)) {
            group.symbols.add(symbol1);
            symbol1.symbolGroup = group;
            break;
          }
        };
      }
    }
  }

  static bool _emptyRow(Image.Image bmp, int startColumn, int endColumn, int row, int blackLevel) {
    for (int x = startColumn; x <= endColumn; x++) {
      var pixel = bmp.getPixel(x, row);
      if (_blackPixel(pixel, blackLevel)) return false;
    }
    return true;
  }

  static bool _blackPixel(int color, int blackLevel) {
    return (Image.getLuminance(color) <= blackLevel);
  }
}

class _SymbolRow {
  ui.Rect size;
  Image.Image bmp;
  var symbols = <_Symbol>[];
  Uint8List _outputImageBytes;

  _SymbolRow(ui.Rect size, Image.Image bmp) {
    this.size = size;
    this.bmp = bmp;
  }

  Uint8List getImage() {
    if (_outputImageBytes != null)
      return _outputImageBytes;

    _outputImageBytes = encodeTrimmedPng(bmp);
    return _outputImageBytes;
  }

  _splitLineToSymbols(int gap, int blackLevel) {
    var emptyColumnIndex = <int>[];

    for (int x = 0; x < bmp.width; x++) {
      var emptyColumn = true;
      for (int y = 0; y < bmp.height; y++) {
        var pixel = bmp.getPixel(x, y);

        if (SymbolImage._blackPixel(pixel, blackLevel)) {
          emptyColumn = false;
          break;
        }
      }
      if (emptyColumn) emptyColumnIndex.add(x);
    }

    if (emptyColumnIndex.length > 0) {
      emptyColumnIndex = _removeGapColumns(emptyColumnIndex, gap);

      if (emptyColumnIndex.first != 0)
        _cutSymbol(0, emptyColumnIndex.first - 1, blackLevel);

      for (int i = 1; i < emptyColumnIndex.length; i++) {
        if (emptyColumnIndex[i - 1] != emptyColumnIndex[i] - 1)
          _cutSymbol(emptyColumnIndex[i - 1] + 1, emptyColumnIndex[i] - 1, blackLevel);
      }

      if ((emptyColumnIndex.last != bmp.width - 1) & (emptyColumnIndex.last != 0))
        _cutSymbol(emptyColumnIndex.last + 1, bmp.width - 1, blackLevel);
    }
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

  ui.Rect _cutSymbol(int startIndex, int endIndex, int blackLevel) {
    var rect = new ui.Rect.fromLTWH(
        startIndex.toDouble(),
        0,
        (endIndex - startIndex).toDouble(),
        bmp.height.toDouble());

    if (rect.width > 0) {
      var box = _boundingBox(bmp, rect, blackLevel);
      var refPoint = ui.Offset(box.left, box.top);
      refPoint = refPoint.translate(size.left, size.top);
      symbols.add(new _Symbol(refPoint,
          Image.copyCrop(bmp,
              box.left.toInt(),
              box.top.toInt(),
              box.width.toInt(),
              box.height.toInt()),
              this
      ));
    }
    return rect;
  }

  ui.Rect _boundingBox(Image.Image bmp, ui.Rect rect, int blackLevel) {
    var startRow = rect.top.toInt();
    var endRow = rect.bottom.toInt() - 1;

    for (int y = rect.top.toInt(); y <= rect.bottom - 1; y++) {
      if (!SymbolImage._emptyRow(bmp, rect.left.toInt(), rect.right.toInt(), y, blackLevel)) {
        startRow = y;
        break;
      }
    }

    for (int y = rect.bottom.toInt() - 1; y >= rect.top; y--) {
      if (!SymbolImage._emptyRow(bmp, rect.left.toInt(), rect.right.toInt(), y, blackLevel)) {
        endRow = y + 1;
        break;
      }
    }
    return ui.Rect.fromLTWH(rect.left, startRow.toDouble(), rect.width, (endRow - startRow).toDouble());
  }
}

class _Symbol {
  ui.Offset refPoint;
  Image.Image bmp; // bitmap;
  int hash;
  _SymbolRow row;
  SymbolGroup symbolGroup;
  Uint8List _outputImageBytes;


  _Symbol(ui.Offset refPoint, Image.Image bmp, _SymbolRow row) {
    this.refPoint = refPoint;
    this.bmp = bmp;
    this.row = row;
  }

  Uint8List getImage() {
    if (_outputImageBytes != null)
      return _outputImageBytes;

    _outputImageBytes = encodeTrimmedPng(bmp);
    return _outputImageBytes;
  }
}

class SymbolGroup {
  String text;
  bool viewGroupImage = false;
  var symbols = <_Symbol>[];
  Uint8List _outputImageGroupBytes;

  Uint8List getImage() {
    if (symbols.isNotEmpty)
      return symbols.first.getImage();
    return null;
  }

  Uint8List getGroupImage() {
    if (_outputImageGroupBytes != null)
      return _outputImageGroupBytes;

    var bmp = _buildSymbolGroupView();
    if (bmp != null) {
      _outputImageGroupBytes = encodeTrimmedPng(bmp);
      return _outputImageGroupBytes;
    }
  }

  Image.Image _buildSymbolGroupView( {int height = 0}) {
    const gap = 2;
    var targetRatio = 3;
    bool cancel = false;
    var cancelCounter = 0;
    ui.Offset size;
    ui.Offset rowSize;
    var maxWidth = 999999999.0;

    do {
      size = new ui.Offset(0, 0);
      rowSize = new ui.Offset(0, 0);
      symbols.forEach((symbol) {
        if (rowSize.dx + symbol.bmp.width + gap > maxWidth) {
          size = size.translate(max(rowSize.dx, size.dx) - size.dx, rowSize.dy);
          rowSize = ui.Offset(0, 0);
        }

        rowSize = rowSize.translate(
            symbol.bmp.width.toDouble() + gap,
            max(rowSize.dy, symbol.bmp.height.toDouble() + gap) - rowSize.dy
        );
      });
      size = size.translate(max(rowSize.dx, size.dx) - size.dx, rowSize.dy + gap);

      var ratio = size.dx / size.dy;
      if (ratio > targetRatio && symbols.length > 4)
        maxWidth = (size.dx * (cancelCounter == 0 ? 1.0 / 2.0 : 2.0 / 3.0));
      else
        cancel = true;

      cancelCounter++;
    } while (!cancel && (cancelCounter < 6));

    size = size.translate(-gap.toDouble(), -gap.toDouble());
    var image = Image.Image(size.dx.toInt(), size.dy.toInt());
    var offset = ui.Offset(0, 0);

    var rowHeight = 0;
    symbols.forEach((symbol) {
      if (offset.dx + symbol.bmp.width + gap > size.dx) {
        offset.translate(-offset.dx, rowHeight.toDouble());
        rowHeight = 0;
      }
      Image.drawImage(image, symbol.bmp, dstX: offset.dx.toInt(), dstY: offset.dy.toInt());
      offset = offset.translate(symbol.bmp.width.toDouble() + gap, 0);
      rowHeight = max(rowHeight, symbol.bmp.height + gap);
    });
    return image;
  }
}


/// <summary>
/// Contains a variety of methods useful in generating image hashes for image comparison
/// and recognition.
///
/// Credit for the AverageHash implementation to David Oftedal of the University of Oslo.
/// </summary>
class ImageHashing {
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
