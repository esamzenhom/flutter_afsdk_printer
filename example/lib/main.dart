import 'package:flutter/material.dart';
import 'package:flutter_afsdk_printer/flutter_afsdk_printer.dart'; // ✅ Ensure this is correct

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> printTest() async {
    try {
      await FlutterAFSDKPrinter.printText("Hello, Printer!");
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Printer Test')),
        body: Center(
          child: ElevatedButton(
            onPressed: printTest,
            child: Text('Print'),
          ),
        ),
      ),
    );
  }
}
