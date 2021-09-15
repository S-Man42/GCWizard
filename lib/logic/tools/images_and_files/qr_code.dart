import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:barcode_scanner/barcode_scanning_data.dart';
import 'package:gc_wizard/theme/fixed_colors.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'dart:ui' as ui;
//import 'package:google_ml_kit/google_ml_kit.dart' as google;
import 'package:image/image.dart' as Image;
import 'package:barcode_scanner/scanbot_barcode_sdk.dart' as sacnner1;
import 'package:barcode_scanner/scanbot_sdk_models.dart'  as sacnner2;
//import io.scanbot.sdk.ScanbotSDKInitializer



/// Parse to code string with uint8list
Future<String> scanBytes(Uint8List bytes) async {
  if (bytes == null) return null;
  try {
    //var ocr =google.BarcodeScanner();

    // // Below example uses metadata values based on an RGBA-encoded 1080x1080 image
    // final planeMetadata = google.InputImagePlaneMetadata(
    //   width: 420,
    //   height: 420,
    //   bytesPerRow: 420 * 4,
    // );
    //
    // final imageMetadata = google.InputImageData(
    //   size: Size(420, 420),
    //   planeData: List.from([planeMetadata]),
    //   inputImageFormat : google.InputImageFormat.BGRA8888,
    // );
    //
    // var inputImage = google.InputImage.fromBytes(bytes: bytes,
    //     inputImageData: imageMetadata);
    var file = await createTmpFile('png',bytes);
    // var inputImage = google.InputImage.fromFilePath(file.path);
    //
    // var codes = await ocr.processImage(inputImage);
    // if (codes != null)
    //   return codes.map((code ) {
    //     return code.value.toString();
    //     }).join("\n");
    //scanner2.
    //ScanbotSDKInitializer().initialize(this)
    var config = sacnner2.ScanbotSdkConfig(          licenseKey: "",          loggingEnabled: true      );
    await sacnner1.ScanbotBarcodeSdk.initScanbotSdk(config);
    var codes = await sacnner1.ScanbotBarcodeSdk.detectFromImageFile(file.uri, BarcodeFormat.values.toList());
    if (codes != null)
      return codes.barcodeItems.map((code ) {
        return code.text;
        }).join("\n");
  } catch (e) {
    ;
  }
  return null;
}

/// Generating Bar Code
Future<Uint8List> generateBarCode(String code) async {
  if (code == null || code == "") return null;
  return addBorder(await scanner.generateBarCode(code));
}

Future<Uint8List> addBorder(Uint8List imageBytes, {double border = 10}) async {
  try {
    return addImageBorder(await _bytesToImage(imageBytes), border: border);
  } catch (e) {
    return null;
  }
}

Future<Uint8List> addImageBorder(ui.Image image, {double border = 10}) async {
  try {
    final canvasRecorder = ui.PictureRecorder();
    final rect = ui.Rect.fromLTWH(0, 0, image.width + 2 * border, image.height + 2 * border);
    final canvas = ui.Canvas(canvasRecorder, rect);
    final paint = ui.Paint()
      ..color = COLOR_QR_BACKGROUND
      ..style = ui.PaintingStyle.fill;

    canvas.drawRect(rect, paint);
    canvas.drawImage(image, ui.Offset(border, border), paint);
    image = await canvasRecorder.endRecording().toImage(rect.width.floor(), rect.height.floor());

    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    return data.buffer.asUint8List();
  } catch (e) {
    return null;
  }
}

Future<ui.Image> _bytesToImage(Uint8List imgBytes) async {
  ui.Codec codec = await ui.instantiateImageCodec(imgBytes);
  ui.FrameInfo frame = await codec.getNextFrame();
  return frame.image;
}
