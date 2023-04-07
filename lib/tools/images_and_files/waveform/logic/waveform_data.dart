part of 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform.dart';

final WAV_FORMAT_PCM = 1;
final WAV_FORMAT_IEEEFLOAT32 = 3;
final Map<int, String> WAV_FORMAT_CODE = {
  // http://www-mmsp.ece.mcgill.ca/Documents/AudioFormats/WAVE/Docs/rfc2361.txt
  0: '?',
  1: 'PCM',
  2: 'Microsoft ADPCM',
  3: 'IEEE float',
  4: 'VSELP Windows CE 2.0',
  5: 'IBM CVSD',
  6: '8-Bit ITU G.711 A-law',
  7: '8-Bit ITU G.711 μ-law',
  16: 'OKI ADPCM',
  17: 'IMA ADPCM',
  18: 'Videologic Mediaspace ADPCM',
  19: 'Sierra Semiconductor ADPCM',
  20: 'ITU G.723 ADPCM',
  21: 'DSP Solutions Standard',
  22: 'DSP Solutions Fixed',
  23: 'Dialogic OKI ADPCM',
  24: 'ADPCM for Jazz 16 chip set',
  25: 'CU Codec',
  32: 'Yamaha ADPCM',
  33: 'Speech Compression SONARC',
  34: 'DSP Group TrueSpeech',
  35: 'Echo SC1',
  36: 'Audiofile AF36',
  37: 'APTX',
  38: 'Audiofile AF10',
  48: 'Dolby AC2',
  49: 'GSM 6.10',
  51: 'ANTEX ADPCME',
  52: 'Control Resources Vector Quantized LPC',
  53: 'DSP Solutions Real',
  54: 'DSP Solutions ADPCM',
  55: 'Control Resources CR10',
  56: 'Natural MicroSystems VBX ADPCM',
  64: 'ITU G.721 ADPCM',
  65: 'IBM μ-law',
  66: 'IBM A-law',
  67: 'IBM AVC ADPCM',
  80: 'MPEG',
  128: 'Creative Labs ADPCM',
  192: 'Fujitsu FM Towns',
  256: 'Rhetorex ADPCM',
  257: 'BeCubed IRAT',
  273: 'Vivo G723',
  274: 'Vivo Siren',
  291: 'DEC G723',
  512: 'Creative Labs ADPCM',
  1024: 'Olivetti GSM',
  1025: 'Olivetti ADPCM',
  1026: 'Olivetti SBC',
  1027: 'Olivetti OPR',
};

final Map<String, String> LIST_INFO_CODE = {
  'IARL': 'Location where the subject of the file is archived',
  'IART': 'Artist of the original subject of the file',
  'ICMS': 'Name of the person or organization that commissioned the original subject of the file',
  'ICMT': 'General comments about the file or its subject',
  'ICOP': 'Copyright information about the file (e.g., "Copyright Some Company 2011")',
  'ICRD': 'Date the subject of the file was created',
  'ICRP': 'Whether and how an image was cropped',
  'IDIM': 'Dimensions of the original subject of the file',
  'IDPI': 'Dots per inch settings used to digitize the file',
  'IENG': 'Name of the engineer who worked on the file',
  'IGNR': 'Genre of the subject',
  'IKEY': 'List of keywords for the file or its subject',
  'ILGT': 'Lightness settings used to digitize the file',
  'IMED': 'Medium for the original subject of the file',
  'INAM': 'Title of the subject of the file (name)',
  'IPLT': 'Number of colors in the color palette used to digitize the file',
  'IPRD': 'Name of the title the subject was originally intended for',
  'ISBJ': 'Description of the contents of the file (subject)',
  'ISFT': 'Name of the software package used to create the file',
  'ISRC': 'Name of the person or organization that supplied the original subject of the file',
  'ISRF': 'Original form of the material that was digitized (source form)',
  'ITCH': 'Name of the technician who digitized the subject file',
};

String _WAVchannelMask(int channels) {
  return convertBase(channels.toString(), 10, 2).padLeft(32, '0');
}

String _WAVchannelMaskAnalyze(int channels) {
  // http://www-mmsp.ece.mcgill.ca/Documents/AudioFormats/WAVE/Docs/multichaudP.pdf, page 7
  List<String> result = [];
  if (channels & 1 == 1) result.add('Front, left');
  if (channels & 2 == 2) result.add('Front, right');
  if (channels & 4 == 4) result.add('Front, center');
  if (channels & 8 == 8) result.add('Sub woofer');
  if (channels & 16 == 16) result.add('Back, left');
  if (channels & 32 == 32) result.add('Back, right');
  if (channels & 64 == 64) result.add('Front, left of center');
  if (channels & 128 == 128) result.add('Front, right of center');
  if (channels & 256 == 256) result.add('Back, center');
  if (channels & 512 == 512) result.add('Side, left');
  if (channels & 1024 == 1024) result.add('Side, right');
  if (channels & 2048 == 2048) result.add('Top, center');
  if (channels & 4096 == 4096) result.add('Top, front, left');
  if (channels & 8192 == 8192) result.add('Top, front, center');
  if (channels & 16384 == 16384) result.add('Top, front, right');
  if (channels & 32768 == 32768) result.add('Top, center');
  if (channels & 65536 == 65536) result.add('Top, back, left');
  if (channels & 131072 == 131072) result.add('Top, back, center');
  if (channels & 262144 == 262144) result.add('Top, back, right');
  if (channels & 2147483648 == 2147483648) result.add('Reserved');

  return result.join('\n');
}

SoundfileData WAVContent(Uint8List bytes) {
  // https://www.itwissen.info/WAV-Dateiformat-waveform-audio-file-WAV.html
  // http://www-mmsp.ece.mcgill.ca/Documents/AudioFormats/WAVE/WAVE.html
  // https://de.wikipedia.org/wiki/RIFF_WAVE
  // https://web.archive.org/web/20101207002408/http://www.it.fht-esslingen.de/~schmidt/vorlesungen/mm/seminar/ss00/HTML/node107.html
  // https://www.recordingblogs.com/wiki/wave-file-format

  List<SoundfileDataSection> WaveFormDataSectionList = [];
  SoundfileDataSection section;
  List<SoundfileDataSectionContent> sectionContentList = [];

  int channels = ByteData.sublistView(bytes).getInt16(22, Endian.little);
  int sampleRate = ByteData.sublistView(bytes).getInt32(24, Endian.little);
  int dataRate = ByteData.sublistView(bytes).getInt32(28, Endian.little);
  int bits = ByteData.sublistView(bytes).getInt16(34, Endian.little);
  int dataSize = 0;
  int PCMformat = 0;
  Uint8List amplitudesData = Uint8List.fromList([]);

  int index = 0;
  while (index < bytes.length) {
    switch (index + 4 < bytes.length
        ? String.fromCharCodes(bytes.sublist(index, index + 4))
        : String.fromCharCodes(bytes.sublist(index))) {
      case 'RIFF':
        sectionContentList = [];
        sectionContentList.add(SoundfileDataSectionContent(
            Meaning: 'sign',
            Bytes: bytes.sublist(index, index + 4).join(' '),
            Value: String.fromCharCodes(bytes.sublist(index, index + 4)))); // 4 Byte Big Endian
        sectionContentList.add(SoundfileDataSectionContent(
            Meaning: 'size',
            Bytes: bytes.sublist(index + 4, index + 8).join(' '),
            Value: ByteData.sublistView(bytes).getInt32(index + 4, Endian.little).toString() + ' Byte')); // 4 Byte
        sectionContentList.add(SoundfileDataSectionContent(
            Meaning: 'subtype',
            Bytes: bytes.sublist(index + 8, index + 12).join(' '),
            Value: String.fromCharCodes(bytes.sublist(index + 8, index + 12)))); // 4 Byte Big Endian
        section = SoundfileDataSection(SectionTitle: 'riff_header', SectionContent: sectionContentList);
        WaveFormDataSectionList.add(section);
        index = index + 12;
        break;
      case 'fmt ':
        sectionContentList = [];
        sectionContentList.add(SoundfileDataSectionContent(
            Meaning: 'sign',
            Bytes: bytes.sublist(index, index + 4).join(' '),
            Value: String.fromCharCodes(bytes.sublist(index, index + 4)))); // 4 Byte Big Endian
        sectionContentList.add(SoundfileDataSectionContent(
            Meaning: 'size',
            Bytes: bytes.sublist(index + 4, index + 8).join(' '),
            Value: ByteData.sublistView(bytes).getInt32(index + 4, Endian.little).toString() + ' Byte')); // 4 Byte
        int size = ByteData.sublistView(bytes).getInt32(index + 4, Endian.little);
        sectionContentList.add(SoundfileDataSectionContent(
            Meaning: 'type',
            Bytes: bytes.sublist(index + 8, index + 10).join(' '),
            Value: ByteData.sublistView(bytes).getInt16(index + 8, Endian.little).toString())); // 2 Byte
        PCMformat = ByteData.sublistView(bytes).getInt16(index + 8, Endian.little);
        sectionContentList.add(SoundfileDataSectionContent(
            Meaning: '',
            Bytes: WAV_FORMAT_CODE[ByteData.sublistView(bytes).getInt16(index + 8, Endian.little)]!,
            Value: ''));
        sectionContentList.add(SoundfileDataSectionContent(
            Meaning: 'channel',
            Bytes: bytes.sublist(index + 10, index + 12).join(' '),
            Value: ByteData.sublistView(bytes).getInt16(index + 10, Endian.little).toString())); // 2 Byte
        sectionContentList.add(SoundfileDataSectionContent(
            Meaning: 'samplerate',
            Bytes: bytes.sublist(index + 12, index + 16).join(' '),
            Value: ByteData.sublistView(bytes).getInt32(index + 12, Endian.little).toString() + ' Hz')); // 4 Byte
        sectionContentList.add(SoundfileDataSectionContent(
            Meaning: 'datarate',
            Bytes: bytes.sublist(index + 16, index + 20).join(' '),
            Value: ByteData.sublistView(bytes).getInt32(index + 16, Endian.little).toString() + ' Byte/s')); // 4 Byte
        sectionContentList.add(SoundfileDataSectionContent(
            Meaning: 'totalsamplelength',
            Bytes: bytes.sublist(index + 20, index + 22).join(' '),
            Value: ByteData.sublistView(bytes).getInt16(index + 20, Endian.little).toString() + ' Byte')); // 2 Byte
        sectionContentList.add(SoundfileDataSectionContent(
            Meaning: 'bitspersample',
            Bytes: bytes.sublist(index + 22, index + 24).join(' '),
            Value: ByteData.sublistView(bytes).getInt16(index + 22, Endian.little).toString())); // 2 Byte
        if (size > 16) {
          sectionContentList.add(SoundfileDataSectionContent(
              Meaning: 'extensionsize',
              Bytes: bytes.sublist(index + 24, index + 26).join(' '),
              Value: ByteData.sublistView(bytes).getInt16(index + 24, Endian.little).toString())); // 2 Byte
          size = ByteData.sublistView(bytes).getInt32(index + 24, Endian.little);
          if (size > 0) {
            sectionContentList.add(SoundfileDataSectionContent(
                Meaning: 'validbits',
                Bytes: bytes.sublist(index + 26, index + 28).join(' '),
                Value: ByteData.sublistView(bytes).getInt16(index + 26, Endian.little).toString())); // 2 Byte
            sectionContentList.add(SoundfileDataSectionContent(
                Meaning: 'channelmask',
                Bytes: bytes.sublist(index + 28, index + 32).join(' '),
                Value: _WAVchannelMask(ByteData.sublistView(bytes).getInt32(index + 24, Endian.little)))); // 4 Byte
            sectionContentList.add(SoundfileDataSectionContent(
                Meaning: '',
                Bytes: _WAVchannelMaskAnalyze(ByteData.sublistView(bytes).getInt32(index + 24, Endian.little)),
                Value: '')); // 4 Byte
            sectionContentList.add(SoundfileDataSectionContent(
                Meaning: 'subformat',
                Bytes: bytes.sublist(index + 32, index + 48).join(' '),
                Value: String.fromCharCodes(bytes.sublist(index + 32, index + 48)))); // 16 Byte
          }
        }
        section = SoundfileDataSection(SectionTitle: 'format_chunk', SectionContent: sectionContentList);
        WaveFormDataSectionList.add(section);
        index = index + 24;
        break;
      case 'data':
        sectionContentList = [];
        sectionContentList.add(SoundfileDataSectionContent(
            Meaning: 'sign',
            Bytes: bytes.sublist(index, index + 4).join(' '),
            Value: String.fromCharCodes(bytes.sublist(index, index + 4)))); // 4 Byte Big Endian
        sectionContentList.add(SoundfileDataSectionContent(
            Meaning: 'size',
            Bytes: bytes.sublist(index + 4, index + 8).join(' '),
            Value: ByteData.sublistView(bytes).getInt32(index + 4, Endian.little).toString() + ' Byte')); // 4 Byte
        dataSize = ByteData.sublistView(bytes).getInt32(index + 4, Endian.little);
        amplitudesData = bytes.sublist(index + 8, index + 8 + dataSize);
        if (dataSize % 2 == 0) {
          sectionContentList.add(SoundfileDataSectionContent(Meaning: 'padding', Bytes: 'no padding', Value: ''));
        } // 4 Byte
        else {
          sectionContentList.add(SoundfileDataSectionContent(Meaning: 'padding', Bytes: '1 Byte', Value: '')); // 4 Byte
          amplitudesData.add(0);
        }
        sectionContentList.add(SoundfileDataSectionContent(
            Meaning: 'duration', Bytes: '', Value: (dataSize / dataRate).toStringAsFixed(2) + ' s')); // 4 Byte
        section = SoundfileDataSection(SectionTitle: 'data_chunk', SectionContent: sectionContentList);
        WaveFormDataSectionList.add(section);
        index = index + 8 + dataSize;
        break;
      case 'LIST':
      // https://www.recordingblogs.com/wiki/list-chunk-of-a-wave-file
        sectionContentList = [];
        sectionContentList.add(SoundfileDataSectionContent(
            Meaning: 'sign',
            Bytes: bytes.sublist(index, index + 4).join(' '),
            Value: String.fromCharCodes(bytes.sublist(index, index + 4)))); // 4 Byte Big Endian
        sectionContentList.add(SoundfileDataSectionContent(
            Meaning: 'size',
            Bytes: bytes.sublist(index + 4, index + 8).join(' '),
            Value: ByteData.sublistView(bytes).getInt32(index + 4, Endian.little).toString() + ' Byte')); // 4 Byte
        int size = ByteData.sublistView(bytes).getInt32(index + 4, Endian.little);
        sectionContentList.add(SoundfileDataSectionContent(
            Meaning: 'type',
            Bytes: bytes.sublist(index + 8, index + 12).join(' '),
            Value: String.fromCharCodes(bytes.sublist(index + 8, index + 12)))); // 4 Byte
        String type = String.fromCharCodes(bytes.sublist(index + 8, index + 12));
        if (type == 'INFO') {
          int listIndex = index + 12;
          while (listIndex < index + 8 + size) {
            sectionContentList.add(SoundfileDataSectionContent(
                Meaning: 'subtype',
                Bytes: bytes.sublist(listIndex, listIndex + 4).join(' '),
                Value: String.fromCharCodes(bytes.sublist(listIndex, listIndex + 4)))); // 4 Byte
            sectionContentList.add(SoundfileDataSectionContent(
                Meaning: '',
                Bytes: LIST_INFO_CODE[String.fromCharCodes(bytes.sublist(listIndex, listIndex + 4))].toString(),
                Value: ''));
            sectionContentList.add(SoundfileDataSectionContent(
                Meaning: 'size',
                Bytes: bytes.sublist(listIndex + 4, listIndex + 8).join(' '),
                Value:
                ByteData.sublistView(bytes).getInt32(listIndex + 4, Endian.little).toString() + ' Byte')); // 4 Byte
            int size = ByteData.sublistView(bytes).getInt32(listIndex + 4, Endian.little);
            sectionContentList.add(SoundfileDataSectionContent(
                Meaning: 'data',
                Bytes: bytes.sublist(listIndex + 8, listIndex + 8 + size).join(' '),
                Value: String.fromCharCodes(bytes.sublist(listIndex + 8, listIndex + 8 + size)))); // 4 Byte
            listIndex = listIndex + 8 + size;
          }
        } else {
          sectionContentList.add(SoundfileDataSectionContent(
              Meaning: 'data',
              Bytes: bytes.sublist(index + 8, index + 8 + size).join(' '),
              Value: String.fromCharCodes(bytes.sublist(index + 8, index + 8 + size)))); // 4 Byte
        }
        section = SoundfileDataSection(SectionTitle: 'metadata_chunk', SectionContent: sectionContentList);
        WaveFormDataSectionList.add(section);
        index = index + 8 + size;
        break;
      case 'id3 ':
      // https://id3.org/id3v2.3.0#Private_frame
        sectionContentList = [];
        sectionContentList.add(SoundfileDataSectionContent(
            Meaning: 'sign',
            Bytes: bytes.sublist(index, index + 4).join(' '),
            Value: String.fromCharCodes(bytes.sublist(index, index + 4)))); // 4 Byte Big Endian
        sectionContentList.add(SoundfileDataSectionContent(
            Meaning: 'size',
            Bytes: bytes.sublist(index + 4, index + 8).join(' '),
            Value: ByteData.sublistView(bytes).getInt32(index + 4, Endian.little).toString() + ' Byte')); // 4 Byte
        int size = ByteData.sublistView(bytes).getInt32(index + 4, Endian.little);
//        sectionContentList.add(SoundfileDataSectionContent(Meaning: 'data', Bytes: bytes.sublist(index + 8, index + 8 + size).join(' '), Value: String.fromCharCodes(bytes.sublist(index + 8, index + 8 + size)))); // 4 Byte
        sectionContentList.addAll(analyzeID3Chunk(bytes.sublist(index + 8, index + 8 + size)));
        section = SoundfileDataSection(SectionTitle: 'id3_chunk', SectionContent: sectionContentList);
        WaveFormDataSectionList.add(section);
        index = index + 8 + size;
        break;
      default:
        index++;
    } // switch
  } // while

  return SoundfileData(
    PCMformat: PCMformat,
    bits: bits,
    channels: channels,
    sampleRate: sampleRate,
    amplitudesData: amplitudesData,
    duration: dataSize / dataRate,
    structure: WaveFormDataSectionList,
  );
}

AmplitudeData calculateRMSAmplitudes(
    {required int PCMformat, required int bits, required int channels, required int sampleRate, required Uint8List PCMamplitudesData, required int blocksize, required int vScalefactor}) {

  List<double> RMSperPoint = [];
  double amplitude = 0.0;
  double RMS = 0.0;
  double maxAmplitude = 0.0;

  int samplBlocksize = blocksize * channels * bits ~/ 8;

  if (bits == 24) {
    // https://wiki.multimedia.cx/index.php/PCM
    int sample = 0;
    Map<int, List<int>> LPCM = {};
    while (sample + 6 * channels < PCMamplitudesData.length) {
      amplitude = 0.0;
      for (int c = 0; c < channels * 2; c++) {
        List<int> LPCMc = [];
        LPCMc.add(PCMamplitudesData[sample + c * 2]);
        LPCMc.add(PCMamplitudesData[sample + c * 2 + 1]);
        LPCMc.add(PCMamplitudesData[sample + 2 * channels * 2 + c]);
        LPCM[c] = LPCMc;
      }
      for (int c = 0; c < channels * 2; c++) {
        amplitude = amplitude + LPCM[c]![0] * 256 * 256 + LPCM[c]![1] * 256 + LPCM[c]![2];
      }
      amplitude = amplitude / channels / 2 / 8388608;

      RMS = RMS + amplitude * amplitude;

      if (sample % samplBlocksize == 0) {
        RMSperPoint.add(sqrt(RMS / sampleRate) * vScalefactor);
        RMS = 0;

        maxAmplitude = max(RMSperPoint.last, maxAmplitude);
      }
      sample = sample + 6 * channels;
    }
  } else {
    // 8 Bit, 16 Bit, 32 Bit
    for (int sample = 0; sample < PCMamplitudesData.length; sample = sample + bits ~/ 8 * channels) {
      amplitude = 0.0;
      switch (bits) {
        case 8:
          for (int i = 0; i < channels; i++) {
            amplitude = amplitude + (ByteData.sublistView(PCMamplitudesData).getInt8(sample + i) - 128);
          }
          amplitude = amplitude / channels / 128;
          break;
        case 16:
          if (sample + 4 < PCMamplitudesData.length) {
            for (int i = 0; i < channels; i++) {
              amplitude = amplitude + ByteData.sublistView(PCMamplitudesData).getInt16(sample + i * 2, Endian.little);
            }
            amplitude = amplitude / channels / 32768;
          }
          break;
        case 32:
          if (PCMformat == WAV_FORMAT_PCM) {
            // PCM
            if (sample + 8 < PCMamplitudesData.length) {
              for (int i = 0; i < channels; i++) {
                amplitude = amplitude + ByteData.sublistView(PCMamplitudesData).getInt32(sample + i * 4, Endian.little);
              }
              amplitude = amplitude / channels / 2147483648;
            }
          } else if (PCMformat == WAV_FORMAT_IEEEFLOAT32) {
            // IEEE Float 32
            if (sample + 8 < PCMamplitudesData.length) {
              for (int i = 0; i < channels; i++) {
                amplitude =
                    amplitude + ByteData.sublistView(PCMamplitudesData).getFloat32(sample + i * 4, Endian.little);
              }
              amplitude = amplitude / channels;
            }
          }
          break;
      }
      RMS = RMS + amplitude * amplitude;

      if (sample % samplBlocksize == 0) {
        RMSperPoint.add(sqrt(RMS / sampleRate) * vScalefactor);
        RMS = 0;

        maxAmplitude = max(RMSperPoint.last, maxAmplitude);
      }
    }
  }
  RMSperPoint.add(sqrt(RMS / sampleRate) * vScalefactor);

  return AmplitudeData(maxAmplitude: maxAmplitude, Amplitudes: RMSperPoint);
}
