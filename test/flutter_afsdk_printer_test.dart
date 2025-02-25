import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_afsdk_printer/flutter_afsdk_printer.dart';
import 'package:flutter_afsdk_printer/flutter_afsdk_printer_platform_interface.dart';
import 'package:flutter_afsdk_printer/flutter_afsdk_printer_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterAfsdkPrinterPlatform
    with MockPlatformInterfaceMixin
    implements FlutterAfsdkPrinterPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterAfsdkPrinterPlatform initialPlatform =
      FlutterAfsdkPrinterPlatform.instance;

  test('$MethodChannelFlutterAfsdkPrinter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterAfsdkPrinter>());
  });

  test('getPlatformVersion', () async {
    MockFlutterAfsdkPrinterPlatform fakePlatform =
        MockFlutterAfsdkPrinterPlatform();
    FlutterAfsdkPrinterPlatform.instance = fakePlatform;

    expect(() async => await FlutterAFSDKPrinter.printText("Test Print"), '42');
  });
}
