import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_afsdk_printer_method_channel.dart';

abstract class FlutterAfsdkPrinterPlatform extends PlatformInterface {
  /// Constructs a FlutterAfsdkPrinterPlatform.
  FlutterAfsdkPrinterPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterAfsdkPrinterPlatform _instance = MethodChannelFlutterAfsdkPrinter();

  /// The default instance of [FlutterAfsdkPrinterPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterAfsdkPrinter].
  static FlutterAfsdkPrinterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterAfsdkPrinterPlatform] when
  /// they register themselves.
  static set instance(FlutterAfsdkPrinterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
