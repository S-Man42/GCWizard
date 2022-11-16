import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/n_segment_display.dart';

Widget buildSegmentDisplayOutput(int countColumns, List<dynamic> displays, {double verticalPadding: 5, double horizontalPadding: 5}) {
  var _verticalPadding = verticalPadding ?? 5.0;
  var _horizontalPadding = horizontalPadding ?? 5.0;

  var rows = <Widget>[];
  var countRows = (displays.length / countColumns).floor();

  for (var i = 0; i <= countRows; i++) {
    var columns = <Widget>[];

    for (var j = 0; j < countColumns; j++) {
      var widget;
      var displayIndex = i * countColumns + j;

      if (displayIndex < displays.length) {
        var display = displays[displayIndex];

        widget = Container(
          child: display,
          padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
        );
      } else {
        widget = Container();
      }

      columns.add(Expanded(
          child: Container(
        child: widget,
        padding: EdgeInsets.symmetric(vertical: _verticalPadding),
      )));
    }

    rows.add(Row(
      children: columns,
    ));
  }

  return Column(
    children: rows,
  );
}

Widget buildPunchtapeSegmentDisplayOutput(List<dynamic> displays) {
  var rows = <Widget>[];

  for (var displayIndex = 0; displayIndex < displays.length; displayIndex++) {
    var columns = <Widget>[];
    var widget;
    var display = displays[displayIndex];

    widget = Container(
      width: 200,
      height: 40,
      child: display,
      padding: EdgeInsets.all(2),
    );

    columns.add(Expanded(
        child: Container(
      child: widget,
      padding: EdgeInsets.all(3),
    )));

    rows.add(Row(
      children: columns,
    ));
  }

  return Container(
      width: 300,
      child: Column(
        children: rows,
      ));
}

Future<ui.Image> buildSegmentDisplayImage(int countColumns, List<NSegmentDisplay> displays, bool upsideDown, {double verticalPadding, double horizontalPadding}) async {
  const double bounds = 3.0;
  var _verticalPadding = verticalPadding ?? 5.0;
  var _horizontalPadding = horizontalPadding ?? 5.0;

  var width = 0.0;
  var height = 0.0;
  var columnCounter = 0;
  var rowWidth = 0.0;
  var rowHeight = 0.0;
  var images = <ui.Image>[];
  var offset = ui.Offset(0, bounds);

  if (displays == null) return null;

  // create images
  for (var i = 0; i < displays.length; i++) images.add(await displays[i].renderedImage);

  // calc image size
  images.forEach((image) {
    rowWidth += image.width + 2 * _horizontalPadding;
    width = max(width, rowWidth);
    rowHeight = max(rowHeight, image.height.toDouble() + 2 * _verticalPadding);
    columnCounter++;

    if (columnCounter >= countColumns) {
      height += rowHeight;
      rowWidth = 0;
      rowHeight = 0;
      columnCounter = 0;
    }
  });

  width = width + 2 * bounds;
  height = height + rowHeight + 2 * bounds;

  final canvasRecorder = ui.PictureRecorder();
  final canvas = ui.Canvas(canvasRecorder, ui.Rect.fromLTWH(0, 0, width, height));

  final paint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;

  canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);

  var countRows = (images.length / countColumns).floor();

  for (var i = 0; i <= countRows; i++) {
    offset = ui.Offset(bounds, offset.dy);
    rowHeight = 0;

    for (var j = 0; j < countColumns; j++) {
      var imageIndex = i * countColumns + j;

      if (imageIndex < images.length) {
        var image = images[imageIndex];
        var middlePoint = ui.Offset(offset.dx + _horizontalPadding + image.width / 2, offset.dy + _verticalPadding + image.height / 2);
        if (upsideDown) {
          canvas.translate(middlePoint.dx, middlePoint.dy);
          canvas.rotate(pi);
          canvas.translate(-middlePoint.dx, -middlePoint.dy);
        }
        canvas.drawImage(image, offset.translate(_horizontalPadding, _verticalPadding), paint);
        if (upsideDown) {
          canvas.translate(middlePoint.dx, middlePoint.dy);
          canvas.rotate(pi);
          canvas.translate(-middlePoint.dx, -middlePoint.dy);
        }
        offset = offset.translate(image.width.toDouble() + 2 * _horizontalPadding, 0);
        rowHeight = max(rowHeight, image.height.toDouble() + 2 * _verticalPadding);
      }
    }
    offset = offset.translate(0, rowHeight);
  }
  return canvasRecorder.endRecording().toImage(width.toInt(), height.toInt());
}

Future<ui.Image> buildPunchtapeSegmentDisplayImage(List<NSegmentDisplay> displays, bool upsideDown) async {
  const double bounds = 3.0;
  const double padding = 2.0;
  var width = 0.0;
  var height = 0.0;
  var rowWidth = 0.0;
  var rowHeight = 0.0;
  var images = <ui.Image>[];
  var offset = ui.Offset(0, bounds);

  if (displays == null) return null;

  // create images
  for (var i = 0; i < displays.length; i++) {
    images.add(await displays[i].renderedImage);
  }

  // calc image size
  images.forEach((image) {
    rowWidth = max(rowWidth, image.width.toDouble() + 2 * padding);
    width = max(width, rowWidth);
    rowHeight += image.height + 6 * padding;
    height = max(height, rowHeight);
  });

  width = width + 2 * bounds;
  height = height + 2 * bounds;

  final canvasRecorder = ui.PictureRecorder();
  final canvas = ui.Canvas(canvasRecorder, ui.Rect.fromLTWH(0, 0, width, height));

  final paint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;

  canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);

  for (var imageIndex = 0; imageIndex < images.length; imageIndex++) {
    offset = ui.Offset(bounds, offset.dy);
    rowHeight = 0;

    var image = images[imageIndex];
    var middlePoint = ui.Offset(offset.dx + padding + image.width / 2, offset.dy + padding + image.height / 2);
    if (upsideDown) {
      canvas.translate(middlePoint.dx, middlePoint.dy);
      canvas.rotate(pi);
      canvas.translate(-middlePoint.dx, -middlePoint.dy);
    }
    canvas.drawImage(image, offset.translate(padding, padding * 3), paint);
    if (upsideDown) {
      canvas.translate(middlePoint.dx, middlePoint.dy);
      canvas.rotate(pi);
      canvas.translate(-middlePoint.dx, -middlePoint.dy);
    }
    offset = offset.translate(image.height.toDouble() + 3 * padding, 0);
    rowHeight = max(rowHeight, image.height.toDouble() + 3 * padding);

    offset = offset.translate(0, rowHeight);
  }
  return canvasRecorder.endRecording().toImage(width.toInt(), height.toInt());
}
