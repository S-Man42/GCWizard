import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class GCWImageViewFullScreen extends StatefulWidget {
  final Uint8List imageData;
  final Function onBeforeFullscreen;

  const GCWImageViewFullScreen({Key key, @required this.imageData, this.onBeforeFullscreen}) : super(key: key);

  @override
  GCWImageViewFullScreenState createState() => GCWImageViewFullScreenState();
}

class GCWImageViewFullScreenState extends State<GCWImageViewFullScreen> {
  ImageProvider image;

  @override
  void initState() {
    super.initState();

    if (widget.onBeforeFullscreen != null) {
      image = MemoryImage(widget.onBeforeFullscreen());
    } else {
      image = MemoryImage(widget.imageData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PhotoView(imageProvider: image);
  }
}
