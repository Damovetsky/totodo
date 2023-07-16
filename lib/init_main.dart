import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'core/di/di.dart';
import 'domain/repositories/config_repository.dart';

Future<void> initMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await configureDependencies();
  await getIt.get<ConfigRepository>().init();
}
