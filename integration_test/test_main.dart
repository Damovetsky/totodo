import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totodo/core/di/di.dart';
import 'package:totodo/generated/codegen_loader.g.dart';
import 'package:totodo/main.dart';
import 'package:totodo/view/providers/tasks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await configureDependencies();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      child: ChangeNotifierProvider(
        create: (context) => getIt.get<Tasks>(),
        child: const App(),
      ),
    ),
  );
}
