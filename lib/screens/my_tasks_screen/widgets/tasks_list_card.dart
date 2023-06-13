import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/dimentions.dart';
import '../../../core/ui/text_styles.dart';
import '../../../core/ui/color_schemes.dart';
import './task_tile.dart';
import '../../../providers/tasks.dart';

class TasksListCard extends StatelessWidget {
  const TasksListCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final tasksData = Provider.of<Tasks>(context);
    final tasks = tasksData.tasks;

    return SliverToBoxAdapter(
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: screenHorizontalMargin,
          vertical: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: currentColorScheme(context).surface,
        clipBehavior: Clip.antiAlias, //???
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasks.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => TaskTile(
                task: tasks[index],
              ),
              shrinkWrap: true,
            ),
            Container(
              height: 48,
              padding: const EdgeInsets.only(left: 52, bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                'Новое',
                style: currentTextTheme(context).bodyMedium?.copyWith(
                      color: currentColorScheme(context).onSurfaceVariant,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
