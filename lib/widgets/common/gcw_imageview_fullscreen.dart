
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class GCWImageViewFullScreen extends StatefulWidget {
  final ImageProvider imageProvider;
  final Function onBeforeFullscreen;

  const GCWImageViewFullScreen({Key key, @required this.imageProvider, this.onBeforeFullscreen}) : super(key: key);

  @override
  GCWImageViewFullScreenState createState() => GCWImageViewFullScreenState();
}

class GCWImageViewFullScreenState extends State<GCWImageViewFullScreen> {
  ImageProvider image;

  @override
  void initState() {
    super.initState();

    if (widget.onBeforeFullscreen != null) {
      image = widget.onBeforeFullscreen(widget.imageProvider);
    } else {
      image = widget.imageProvider;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PhotoView(imageProvider: image);
  }
}
