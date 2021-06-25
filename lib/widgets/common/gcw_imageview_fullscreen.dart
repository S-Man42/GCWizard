
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class GCWImageViewFullScreen extends StatefulWidget {
  final ImageProvider imageProvider;
  final Function onBeforeFullscreen;
  final Function onBeforeFullscreenAsync;

  const GCWImageViewFullScreen({Key key, @required this.imageProvider, this.onBeforeFullscreen, this.onBeforeFullscreenAsync}) : super(key: key);

  @override
  GCWImageViewFullScreenState createState() => GCWImageViewFullScreenState();
}

class GCWImageViewFullScreenState extends State<GCWImageViewFullScreen> {
  ImageProvider image;

  @override
  Future<void> initState() async {
    super.initState();

    if (widget.onBeforeFullscreen != null)
      image =  widget.onBeforeFullscreen(widget.imageProvider);
    else if (widget.onBeforeFullscreenAsync != null)
        image = await widget.onBeforeFullscreenAsync(widget.imageProvider);
    else {
      image = widget.imageProvider;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PhotoView(imageProvider: image);
  }
}
