import 'package:flutter/services.dart';

class FlutterAFSDKPrinter {
  static const MethodChannel _channel = MethodChannel('flutter_afsdk_printer');

  static Future<void> printText(String text) async {
    try {
      await _channel.invokeMethod('printText', {"text": text});
    } on PlatformException catch (e) {
      print("Failed to print: '${e.message}'.");
    }
  }
}
