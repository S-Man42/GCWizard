part of 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform.dart';

class SoundfileOutput {
  final List<Widget> Widgets;

  SoundfileOutput({required this.Widgets});
}

class SoundfileData {
  final List<SoundfileDataSection> structure;
  final int PCMformat;
  final int bits;
  final int channels;
  final int sampleRate;
  final double duration;
  final Uint8List amplitudesData;

  SoundfileData({required this.PCMformat, required this.bits, required this.channels, required this.sampleRate, required this.structure, required this.duration, required this.amplitudesData});
}

class SoundfileDataSection {
  final String SectionTitle;
  final List<SoundfileDataSectionContent> SectionContent;

  SoundfileDataSection({required this.SectionTitle, required this.SectionContent});
}

class SoundfileDataSectionContent {
  final String Meaning;
  final String Bytes;
  final String Value;

  SoundfileDataSectionContent({required this.Meaning, required this.Bytes, required this.Value});
}

class MorseData {
  final Uint8List MorseImage;
  final List<bool> MorseCode;

  MorseData({required this.MorseImage, required this.MorseCode});
}

class AmplitudeData {
  final double maxAmplitude;
  final List<double> Amplitudes;

  AmplitudeData({required this.maxAmplitude, required this.Amplitudes});
}
