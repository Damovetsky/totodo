import 'package:flutter/material.dart';

import '../../../try_server/tasks_server.dart';
import '../task_screen/task_detail_screen.dart';
import './widgets/my_tasks_appbar.dart';
import '../../../core/ui/color_schemes.dart';
import 'widgets/tasks_list_card.dart';

class MyTasksScreen extends StatelessWidget {
  static const routeName = '/';

  const MyTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentColorScheme(context).background,
      body: const CustomScrollView(
        slivers: [
          MyTasksAppBar(),
          TasksListCard(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //Navigator.of(context).pushNamed(TaskDetailScreen.routeName);
          TasksServer server = TasksServer();
          server.addTask();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
