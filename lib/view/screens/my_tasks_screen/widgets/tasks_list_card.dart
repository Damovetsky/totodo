import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/di/di.dart';
import '../../../../core/ui/dimentions.dart';
import '../../../../core/ui/text_styles.dart';
import '../../../../core/ui/color_schemes.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../logger.dart';
import '../../../navigation/tasks_router_deligate.dart';
import './task_tile.dart';
import '../../../providers/tasks.dart';

class TasksListCard extends StatefulWidget {
  const TasksListCard({
    super.key,
  });

  @override
  State<TasksListCard> createState() => _TasksListCardState();
}

class _TasksListCardState extends State<TasksListCard> {
  bool _isInit = true;
  bool _isLoading = false;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  Future<void> _tasksInitialization() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Tasks>(context, listen: false).setListKey(_listKey);
      await Provider.of<Tasks>(context, listen: false).fetchAndSetTasks();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
  }

  @override
  void initState() {
    super.initState();
    unawaited(_tasksInitialization());
  }

  @override
  Widget build(BuildContext context) {
    final tasksData = Provider.of<Tasks>(context);
    final tasks = tasksData.tasks;
    final showCompleted = tasksData.showCompleted;

    logger.d('TaskListCard bulid method is called');

    return SliverToBoxAdapter(
      child: _isLoading
          ? const SizedBox(
              height: 200,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Card(
              margin: const EdgeInsets.symmetric(
                horizontal: screenHorizontalMargin,
                vertical: 24,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: currentColorScheme(context).surface,
              clipBehavior: Clip.antiAlias,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedList(
                    key: _listKey,
                    physics: const NeverScrollableScrollPhysics(),
                    initialItemCount: tasks.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index, animation) {
                      if (!showCompleted && tasks[index].isChecked) {
                        return const SizedBox(
                          height: 0,
                        );
                      }
                      return SizeTransition(
                        sizeFactor: animation,
                        child: TaskTile(
                          task: tasks[index],
                        ),
                      );
                    },
                    shrinkWrap: true,
                  ),
                  GestureDetector(
                    onTap: () =>
                        getIt.get<TasksRouterDeligate>().showNewTaskScreen(),
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.only(left: 52, bottom: 8),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        LocaleKeys.new_task.tr(),
                        style: currentTextTheme(context).bodyMedium?.copyWith(
                              color:
                                  currentColorScheme(context).onSurfaceVariant,
                            ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
