import 'package:flutter/material.dart';

import './core/ui/theme.dart';
import './screens/my_tasks_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToToDo',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const MyTasksScreen(),
    );
  }
}
