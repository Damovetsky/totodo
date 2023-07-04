import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './core/ui/theme.dart';
import 'core/di/di.dart';
import 'generated/codegen_loader.g.dart';
import 'view/navigation/tasks_route_information_parser.dart';
import 'view/navigation/tasks_router_deligate.dart';
import 'view/providers/tasks.dart';

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

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return MaterialApp.router(
      title: 'ToToDo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerDelegate: getIt.get<TasksRouterDeligate>(),
      routeInformationParser: getIt.get<TasksRouteInformationParser>(),
    );
  }
}
