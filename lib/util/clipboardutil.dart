import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_nano_core/flutter_nano_core.dart';

class ClipboardUtil {
  static StreamSubscription<dynamic> setStream;

  /// Set to clear clipboard after 2 minutes, if clipboard contains a seed
  static Future<void> setClipboardClearEvent() async {
    if (setStream != null) {
      setStream.cancel();
    }
    Future<dynamic> delayed = new Future.delayed(new Duration(minutes: 2));
    delayed.then((_) {
      return true;
    });
    setStream = delayed.asStream().listen((_) {
      Clipboard.getData("text/plain").then((data) {
        if (data != null && data.text != null && NanoSeeds.isValidSeed(data.text)) {
          Clipboard.setData(ClipboardData(text: ""));
        }
      });
    });
  }
}