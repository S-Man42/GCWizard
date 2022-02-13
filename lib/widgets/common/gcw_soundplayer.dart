import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
//import 'package:audioplayers/audioplayers.dart'; // https://pub.dev/packages/audioplayers
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:just_audio/just_audio.dart'; // https://pub.dev/packages/just_audio
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_slider.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart';

enum PlayerState { stopped, playing, paused }

class GCWSoundPlayer extends StatefulWidget {
  final PlatformFile file;
  final bool showMetadata;

  const GCWSoundPlayer({Key key, @required this.file, this.showMetadata: false}) : super(key: key);

  @override
  _GCWSoundPlayerState createState() => _GCWSoundPlayerState();
}

class _GCWSoundPlayerState extends State<GCWSoundPlayer> {

  //AudioCache audioCache = AudioCache(); // audioplayers
  AudioPlayer advancedPlayer = AudioPlayer();
  PageManager _pageManager;

  @override
  void initState() {
    super.initState();
    advancedPlayer = AudioPlayer();
    _pageManager = PageManager();
    //if (kIsWeb) {
    //  // Calls to Platform.isIOS fails on web
    //  return;
    //}
    //if (Platform.isIOS) {
    //  audioCache.fixedPlayer?.notificationService.startHeadlessService(); // audioplayers
    //}
    //advancedPlayer.onPlayerCompletion.listen((event) {
    //  onComplete();
    //  setState(() => playerState = PlayerState.stopped);
    //});
  }

  @override
  void dispose() {
    //advancedPlayer.stop();
    //advancedPlayer.dispose();
    _pageManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder<ButtonState>(
          valueListenable: _pageManager.buttonNotifier,
          builder: (_, value, __) {
            switch (value) {
              case ButtonState.loading:
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  width: 32.0,
                  height: 32.0,
                  child: const CircularProgressIndicator(),
                );
              case ButtonState.paused:
                return IconButton(
                  icon: const Icon(Icons.play_arrow),
                  iconSize: 32.0,
                  onPressed: _pageManager.play,
                );
              case ButtonState.playing:
                return IconButton(
                  icon: const Icon(Icons.pause),
                  iconSize: 32.0,
                  onPressed: _pageManager.pause,
                );
            }
          },
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
        Expanded(
          child: ValueListenableBuilder<ProgressBarState>(
            valueListenable: _pageManager.progressNotifier,
            builder: (_, value, __) {
              return ProgressBar(
                progress: value.current,
                buffered: value.buffered,
                total: value.total,
              );
            },
          ),
        )
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
    //int result = await advancedPlayer.playBytes(byteData); // audioplayers
    setState(() => playerState = PlayerState.playing);
  }

  Future _AudioPlayerStop() async {
    await advancedPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
    });
  }

}

class StreamSource extends StreamAudioSource {
  //https://github.com/ryanheise/just_audio/issues/531

  Uint8List bytes;

  StreamSource(this.bytes);

  @override
  Future<StreamAudioResponse> request([int start, int end]) async {

    return StreamAudioResponse(
      sourceLength: bytes.length,
      contentLength: (start ?? 0) - (end ?? bytes.length),
      offset: start ?? 0,
      stream: Stream.fromIterable([bytes.sublist(start ?? 0, end)]),
      //contentType: mimeTypes[bytes]!,
    );
  }
}

class PageManager {
  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );
  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);

  AudioPlayer _audioPlayer;

  PageManager() {
    _init();
  }
  void _init() async {
    _audioPlayer = AudioPlayer();
    await _audioPlayer.setUrl('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3');
  }

  void dispose() {
    _audioPlayer.dispose();
  }

  void play() {
    _audioPlayer.play();
  }
  void pause() {
    _audioPlayer.pause();
  }

}

class ProgressBarState {
  ProgressBarState({
     this.current,
     this.buffered,
     this.total,
  });
  final Duration current;
  final Duration buffered;
  final Duration total;
}

enum ButtonState {
  paused, playing, loading
}


