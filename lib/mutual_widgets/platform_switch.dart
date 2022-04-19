import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';

class PlatformSwitch extends StatelessWidget {
  Widget android;
  Widget ios;
  PlatformSwitch({
    this.android,
    this.ios,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return android;
      // Android-specific code
    } else if (Platform.isIOS) {
      // iOS-specific code
      return ios;
    }
    return null;
  }
}
