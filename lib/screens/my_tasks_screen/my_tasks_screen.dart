import 'package:flutter/material.dart';

import './widgets/my_tasks_appbar.dart';
import '../../core/ui/color_schemes.dart';
import 'widgets/tasks_list_card.dart';

class MyTasksScreen extends StatelessWidget {
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
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
