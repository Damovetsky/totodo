import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './core/ui/theme.dart';
import './screens/my_tasks_screen/my_tasks_screen.dart';
import './providers/tasks.dart';
import 'screens/task_screen/task_detail_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Tasks(),
        ),
      ],
      child: MaterialApp(
        title: 'ToToDo',
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        //darkTheme: darkTheme,
        home: const MyTasksScreen(),
      ),
    );
  }
}
