import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_slider.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart';

class GCWSoundPlayer extends StatefulWidget {
  final PlatformFile file;

  const GCWSoundPlayer({Key key, @required this.file}) : super(key: key);

  @override
  _GCWSoundPlayerState createState() => _GCWSoundPlayerState();
}

class _GCWSoundPlayerState extends State<GCWSoundPlayer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GCWIconButton(
          iconData: Icons.play_arrow,
          onPressed: () {},
        ),
        GCWIconButton(
          iconData: Icons.stop,
          onPressed: () {},
        ),
        Expanded(
          child: GCWSlider(value: 0.0, min: 0.0, max: 100.0, suppressReset: true),
        ),
        GCWText(text: '0:42 / 10:00')
      ],
    );
  }
}
