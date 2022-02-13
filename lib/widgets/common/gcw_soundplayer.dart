import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker_writable/file_picker_writable.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;
import 'package:audioplayers/audioplayers.dart'; // https://pub.dev/packages/audioplayers
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_slider.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart';

import '../utils/file_utils.dart';

enum PlayerState { stopped, playing, paused }

class GCWSoundPlayer extends StatefulWidget {
  final PlatformFile file;
  final bool showMetadata;

  const GCWSoundPlayer({Key key, @required this.file, this.showMetadata: false}) : super(key: key);

  @override
  _GCWSoundPlayerState createState() => _GCWSoundPlayerState();
}

class _GCWSoundPlayerState extends State<GCWSoundPlayer> {

  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      // Calls to Platform.isIOS fails on web
      return;
    }
    if (Platform.isIOS) {
      audioCache.fixedPlayer?.notificationService.startHeadlessService();
    }
    advancedPlayer.onPlayerCompletion.listen((event) {
      onComplete();
      setState(() => playerState = PlayerState.stopped);
    });
  }

  @override
  void dispose() {
    advancedPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GCWIconButton(
          iconData: Icons.play_arrow,
          onPressed: isPlaying
              ? null
              : () => _AudioPlayerPlay(widget.file.bytes),
        ),
        GCWIconButton(
          iconData: Icons.stop,
          onPressed: isPlaying || isPaused ? () => _AudioPlayerStop() : null,
        ),
        if (widget.showMetadata)
          Expanded(
            child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GCWText(
                              text: widget.file.name,
                              style: gcwTextStyle()
                                  .copyWith(fontWeight: FontWeight.bold, color: themeColors().dialogText())),
                        ),
                      ],
                    )
                  ],
                ),
                color: themeColors().accent(),
                padding: EdgeInsets.all(DOUBLE_DEFAULT_MARGIN)),
          ),
//        Expanded(
//          child: GCWSlider(value: 0.0, min: 0.0, max: 100.0, suppressReset: true),
//        ),
//        GCWText(text: '0:42 / 10:00')
      ],
    );
  }

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
  }

  _AudioPlayerPlay(Uint8List byteData) async {
    // save byteData to File
    String fileName = 'tempfile';
    File file;

    if (kIsWeb) {
      var blob = new html.Blob([byteData], 'image/png');
      html.AnchorElement(
        href: html.Url.createObjectUrl(blob),
      )
        ..setAttribute("download", fileName)
        ..click();
      int result = await advancedPlayer.playBytes(byteData);

      return Future.value(byteData);
    } else {
        file = await _writeToFile(ByteData.sublistView(byteData)); // <= returns File
    }

    setState(() => playerState = PlayerState.playing);

    int result = await advancedPlayer.play(file.path, isLocal: true);
  }

  Future _AudioPlayerStop() async {
    await advancedPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
    });
  }

  Future<File> _writeToFile(ByteData data) async {
    final buffer = data.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = tempPath + '/file_01.tmp'; // file_01.tmp is dump file, can be anything
    return new File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}
