import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './core/ui/theme.dart';
import 'domain/repositories/tasks_repository.dart';
import 'data/services/tasks_db/tasks_db.dart';
import 'data/services/tasks_server/tasks_server.dart';
import 'generated/codegen_loader.g.dart';
import 'view/screens/my_tasks_screen/my_tasks_screen.dart';
import 'view/providers/tasks.dart';
import 'view/screens/task_screen/task_detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final tasksRepository = await initRepo();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      child: ChangeNotifierProvider(
        create: (context) => Tasks(tasksRepository),
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
    return MaterialApp(
      title: 'ToToDo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const MyTasksScreen(),
      routes: {
        TaskDetailScreen.routeName: (context) => const TaskDetailScreen(),
      },
    );
  }
}

Future<TasksRepository> initRepo() async {
  final prefs = await SharedPreferences.getInstance();
  final tasksServer = TasksServerImpl(prefs);
  final tasksDB = IsarService();
  return TasksRepositoryImpl(db: tasksDB, server: tasksServer, prefs: prefs);
}
