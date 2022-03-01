


import 'package:flutter/material.dart';

class DebugUI{}

extension ColorDebug on Color {

  Color debugByColor({double? opacity}) {

    return this.withOpacity(opacity ?? 0.3);

  }

}