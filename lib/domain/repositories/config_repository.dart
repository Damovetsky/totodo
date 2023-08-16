import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../logger.dart';

@lazySingleton
class ConfigRepository {
  final FirebaseRemoteConfig _remoteConfig;

  ConfigRepository(this._remoteConfig);

  Color get importanceColor {
    String strColor = _remoteConfig.getString(_ConfigFields.importanceColor);
    strColor = strColor.trim();
    if (strColor.isNotEmpty && strColor[0] == '#' && strColor.length == 7) {
      final intColor = int.parse('FF${strColor.substring(1)}', radix: 16);
      return Color(intColor);
    } else if (strColor.isNotEmpty &&
        strColor[0] == '#' &&
        strColor.length == 9) {
      final intColor = int.parse(strColor.substring(1), radix: 16);
      return Color(intColor);
    } else {
      logger.d(
        'Incorect format of remote configs for importance color: $strColor',
      );
      return const Color(0xFFFF3B30);
    }
  }

  Future<void> init() async {
    _remoteConfig.setDefaults({
      _ConfigFields.importanceColor: '#FF3B30',
    });
    await _remoteConfig.fetchAndActivate();
  }
}

abstract class _ConfigFields {
  static const importanceColor = 'importance_color';
}
