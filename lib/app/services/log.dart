
import 'dart:convert';
import 'dart:developer';

import 'local_settings.dart';


class Log {
  static s(String f, dynamic msg, {String tag = "‼STRONG‼"}) {
    if (LocalSettings().shouldLog) {
      log("‼️ $tag, $f, $msg ️‼️");
    } else {}
  }

  static e(String f, dynamic msg, {String tag = "❗ERROR❗"}) {
    if (LocalSettings().shouldLog) {
      log("❗️️ $tag, $f, $msg ❗️");
    } else {}
  }

  static n(String f, dynamic msg, {String tag = "NORMAL"}) {
    if (LocalSettings().shouldLog) {
      log("$tag, $f, $msg");
    } else {}
  }

  static j(String f, dynamic msg, {String tag = "JSON"}) {
    if (LocalSettings().shouldLog) {
      log("$tag, $f, ${jsonEncode(msg)}");
    } else {}
  }
}