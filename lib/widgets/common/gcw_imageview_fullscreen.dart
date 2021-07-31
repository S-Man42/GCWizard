import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class GCWImageViewFullScreen extends StatefulWidget {
  final Uint8List imageData;

  const GCWImageViewFullScreen({Key key, @required this.imageData}) : super(key: key);

  @override
  GCWImageViewFullScreenState createState() => GCWImageViewFullScreenState();
}

class GCWImageViewFullScreenState extends State<GCWImageViewFullScreen> {
  ImageProvider image;

  @override
  void initState() {
    super.initState();

    image = MemoryImage(widget.imageData);
  }

  @override
  Widget build(BuildContext context) {
    return PhotoView(imageProvider: image);
  }
}
