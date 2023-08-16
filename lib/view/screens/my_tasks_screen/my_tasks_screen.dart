import 'package:flutter/material.dart';

import '../../../core/di/di.dart';
import '../../navigation/tasks_router_deligate.dart';
import './widgets/my_tasks_appbar.dart';
import '../../../core/ui/color_schemes.dart';
import 'widgets/data_fab.dart';
import 'widgets/language_fab.dart';
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const LanguageFloatingActionButton(),
          const SizedBox(
            width: 8,
          ),
          const DataFloatingActionButton(),
          const SizedBox(
            width: 8,
          ),
          FloatingActionButton(
            heroTag: 'Add task button',
            onPressed: () =>
                getIt.get<TasksRouterDeligate>().showNewTaskScreen(),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
