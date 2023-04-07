import 'dart:typed_data';

import 'package:gc_wizard/tools/images_and_files/waveform/logic/waveform.dart';
import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';

final Map<String, String> ID3_FRAMES = {
  'AENC': 'Audio encryption',
  'APIC': 'Attached picture',
  'COMM': 'Comments',
  'COMR': 'Commercial frame',
  'ENCR': 'Encryption method registration',
  'EQUA': 'Equalization',
  'ETCO': 'Event timing codes',
  'GEOB': 'General encapsulated object',
  'GRID': 'Group identificationtion',
  'IPLS': 'Involved people list',
  'LINK': 'Linked information',
  'MCDI': 'Music CD identifier',
  'MLLT': 'MPEG location lookup table',
  'OWNE': 'Ownership frame',
  'PRIV': 'Private frame',
  'PCNT': 'Play counter',
  'POPM': 'Popularimeter',
  'POSS': 'Position synchronisation frame',
  'RBUF': 'Recommended buffer size',
  'RVAD': 'Relative volume adjustment',
  'RVRB': 'Reverb',
  'SYLT': 'Synchronized lyric/text',
  'SYTC': 'Synchronized tempo codes',
  'TALB': 'Album/Movie/Show title',
  'TBPM': 'BPM (beats per minute)',
  'TCOM': 'Composer',
  'TCON': 'Content type',
  'TCOP': 'Copyright message',
  'TDAT': 'Date',
  'TDLY': 'Playlist delay',
  'TENC': 'Encoded by',
  'TEXT': 'Lyricist/Text writer',
  'TFLT': 'File type',
  'TIME': 'Time',
  'TIT1': 'Content group description',
  'TIT2': 'Title/songname/content ion',
  'TIT3': 'Subtitle/Description refinement',
  'TKEY': 'Initial key',
  'TLAN': 'Language(s)',
  'TLEN': 'Length',
  'TMED': 'Media type',
  'TOAL': 'Original album/movie/show title',
  'TOFN': 'Original filename',
  'TOLY': 'Original lyricist(s)/text',
  'TOPE': 'Original artist(s)/performer(s)',
  'TORY': 'Original release year',
  'TOWN': 'File owner/licensee',
  'TPE1': 'Lead performer(s)/Soloist(s)',
  'TPE2': 'Band/orchestra/accompaniment',
  'TPE3': 'Conductor/performer refinement',
  'TPE4': 'Interpreted, remixed, or otherwise modified by',
  'TPOS': 'Part of a set',
  'TPUB': 'Publisher',
  'TRCK': 'Track number/Position in set',
  'TRDA': 'Recording dates',
  'TRSN': 'Internet radio station name',
  'TRSO': 'Internet radio station owner',
  'TSIZ': 'Size',
  'TSRC': 'ISRC (international standard g code)',
  'TSSE': 'Software/Hardware and settings  encoding',
  'TYER': 'Year',
  'TXXX': 'User defined text information',
  'UFID': 'Unique file identifier',
  'USER': 'Terms of use',
  'USLT': 'Unsychronized lyric/text transcription',
  'WCOM': 'Commercial information',
  'WCOP': 'Copyright/Legal information',
  'WOAF': 'Official audio file webpage',
  'WOAR': 'Official artist/performer webpage',
  'WOAS': 'Official audio source webpage',
  'WORS': 'Official internet radio station',
  'WPAY': 'Payment',
  'WPUB': 'Publishers official webpage',
  'WXXX': 'User defined URL link frame',
};

final List<String> ID3_TEXT_FRAMES = ['TALB', 'TBPM', 'TCOM', 'TCON', 'TCOP', 'TDAT', 'TDLY', 'TENC', 'TEXT', 'TFLT', 'TIME', 'TIT1', 'TIT2', 'TIT3', 'TKEY', 'TLAN', 'TLEN', 'TMED', 'TOAL', 'TOFN', 'TOLY', 'TOPE', 'TORY', 'TOWN', 'TPE1', 'TPE2', 'TPE3', 'TPE4', 'TPOS', 'TPUB', 'TRCK', 'TRDA', 'TRSN', 'TRSO', 'TSIZ', 'TSRC', 'TSSE', 'TYER', 'TXXX',];

int sizeID3(Uint8List bytes) {
  // The ID3v2 tag size is encoded with four bytes where the most significant bit (bit 7) is set to zero in every byte,
  // making a total of 28 bits. The zeroed bits are ignored, so a 257 bytes long tag is represented as $00 00 02 01.
  String byte0 = convertBase(bytes[0].toString(), 10, 2).padLeft(8,'0').substring(1);
  String byte1 = convertBase(bytes[1].toString(), 10, 2).padLeft(8,'0').substring(1);
  String byte2 = convertBase(bytes[2].toString(), 10, 2).padLeft(8,'0').substring(1);
  String byte3 = convertBase(bytes[3].toString(), 10, 2).padLeft(8,'0').substring(1);
  return int.parse(convertBase(byte0 + byte1 + byte2 + byte3, 2, 10));
}

String ID3HeaderFlags(Uint8List bytes){
  List<String> flags = [];
  if (bytes[0] & 128 == 128) flags.add('Unsynchronisation is used');
  if (bytes[0] & 64 == 64) flags.add('Extended Header is used');
  if (bytes[0] & 32 == 128) flags.add('Experimental tags are used');
  return flags.join('\n');
}

String ID3FrameFlags(Uint8List bytes){
  List<String> flags = [];
  if (bytes[0] & 128 == 128) flags.add('Unknown frame: Frame should be discarded');
  if (bytes[0] & 64 == 64) flags.add('Frame should be discarded');
  if (bytes[0] & 32 == 128) flags.add('Frame is read only');
  if (bytes[1] & 128 == 128) flags.add('Frame is compressed');
  if (bytes[1] & 64 == 64) flags.add('Frame is encrypted');
  if (bytes[1] & 32 == 128) flags.add('Frame contains group information');
  return flags.join('\n');
}

String ID3TextEncoding(Uint8List bytes){
  if (bytes[0] == 0) {
    return 'ISO 8859-1';
  } else {
    return 'Unicode';
  }
}

List<SoundfileDataSectionContent> analyzeID3Chunk(Uint8List bytes){
  List<SoundfileDataSectionContent> result = [];
  result.add(SoundfileDataSectionContent(Meaning: 'sign', Bytes: bytes.sublist(0, 3).join(' '), Value: String.fromCharCodes(bytes.sublist(0, 3)))); // 3 Byte ASCII
  result.add(SoundfileDataSectionContent(Meaning: 'version', Bytes: bytes.sublist(3, 5).join(' '), Value: bytes[3].toString() + '.' + bytes[4].toString())); // 2 Byte
  result.add(SoundfileDataSectionContent(Meaning: 'flags', Bytes: bytes.sublist(5, 6).join(' '), Value: '')); // 1 Byte
  if (ID3HeaderFlags(bytes.sublist(5, 6)) != '') {
    result.add(SoundfileDataSectionContent(
        Meaning: '', Bytes: ID3HeaderFlags(bytes.sublist(5, 6)), Value: '')); // 4 Byte ASCII
  }
  result.add(SoundfileDataSectionContent(Meaning: 'size', Bytes: bytes.sublist(6, 10).join(' '), Value: sizeID3(bytes.sublist(6, 10)).toString() + ' Byte')); // 4 Bytes, special Format

  int index = 10;
//  int indexText = 0;
  int size = 0;
  String frame = '';
//  String frameText = '';
  while (index < bytes.length) {
    result.add(SoundfileDataSectionContent(Meaning: 'frame',
        Bytes: bytes.sublist(index, index + 4).join(' '),
        Value: String.fromCharCodes(bytes.sublist(index, index + 4)))); // 4 Byte ASCII
    frame = String.fromCharCodes(bytes.sublist(index, index + 4));
    result.add(SoundfileDataSectionContent(Meaning: '',
        Bytes: ID3_FRAMES[String.fromCharCodes(bytes.sublist(index, index + 4))].toString(),
        Value: '')); // 4 Byte ASCII
    size = sizeID3(bytes.sublist(index + 4, index + 8));
    result.add(SoundfileDataSectionContent(Meaning: 'size',
        Bytes: bytes.sublist(index + 4, index + 8).join(' '),
        Value: size.toString() + ' Byte')); // 4 Bytes, special Format
    result.add(SoundfileDataSectionContent(
        Meaning: 'flags', Bytes: bytes.sublist(index + 8, index + 10).join(' '), Value: '')); // 4 Bytes, special Format
    if (ID3FrameFlags(bytes.sublist(index + 8, index + 10)) != '') {
      result.add(SoundfileDataSectionContent(
          Meaning: '', Bytes: ID3FrameFlags(bytes.sublist(index + 8, index + 10)), Value: '')); // 4 Byte ASCII}
      if (ID3_TEXT_FRAMES.contains(frame)) {
        result.add(SoundfileDataSectionContent(Meaning: 'encoding',
            Bytes: bytes.sublist(index + 10, index + 11).join(' '),
            Value: ID3TextEncoding(bytes.sublist(index + 10, index + 11)))); // 1 Byte
//      indexText = 0;
//      while (bytes[index + 11 + indexText] != 0 && indexText < size) {
//        frameText = frameText + String.fromCharCode(bytes[indexText == 0 ? 32 : indexText]);
//        indexText++;
//      }
//      result.add(SoundfileDataSectionContent(Meaning: 'data', Bytes: bytes.sublist(index + 11, index + 11 + indexText).join(' '), Value: frameText)); // ? Byte
      } else {

      }
      result.add(SoundfileDataSectionContent(Meaning: 'data',
          Bytes: bytes.sublist(index + 11, index + 11 + size).join(' '),
          Value: String.fromCharCodes(bytes.sublist(index + 11, index + 11 + size)))); // 4 Byte
      index = index + 11 + size;
    }
  }
  return result;
}