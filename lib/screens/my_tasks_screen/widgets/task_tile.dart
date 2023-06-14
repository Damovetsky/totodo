import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/color_schemes.dart';
import '../../../core/ui/text_styles.dart';
import '../../../models/task.dart';
import '../../../providers/tasks.dart';
import '../../task_screen/task_detail_screen.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({
    required this.task,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Tasks>(
      builder: (context, tasks, _) => Dismissible(
        key: ValueKey(task.id),
        background: Container(
          alignment: Alignment.centerLeft,
          color: greenColor,
          child: const Padding(
            padding: EdgeInsets.only(left: 24),
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ),
        secondaryBackground: Container(
          alignment: Alignment.centerRight,
          color: redColor,
          child: const Padding(
            padding: EdgeInsets.only(right: 24),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
        onUpdate: (details) {
          if (details.direction == DismissDirection.startToEnd &&
              details.progress > 0.3 &&
              !task.isChecked) {
            Provider.of<Tasks>(context, listen: false).toggleTask(task.id);
          }
        },
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            Provider.of<Tasks>(context, listen: false).removeTask(task.id);
          }
        },
        confirmDismiss: (direction) {
          if (direction == DismissDirection.startToEnd) {
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          constraints: const BoxConstraints(minHeight: 48, maxHeight: 106),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: task.isChecked,
                activeColor: greenColor,
                onChanged: (value) {
                  Provider.of<Tasks>(context, listen: false)
                      .toggleTask(task.id);
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        task.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: task.isChecked
                            ? currentTextTheme(context).bodyMedium?.copyWith(
                                  color: currentColorScheme(context)
                                      .onSurfaceVariant,
                                  decoration: TextDecoration.lineThrough,
                                )
                            : currentTextTheme(context).bodyMedium,
                      ),
                      if (task.dueDate != null)
                        Text(
                          DateFormat.yMMMMd('ru').format(task.dueDate!),
                          style: currentTextTheme(context).titleSmall?.copyWith(
                                color: currentColorScheme(context)
                                    .onSurfaceVariant,
                              ),
                        )
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(TaskDetailScreen.routeName, arguments: task);
                },
                icon: Icon(
                  Icons.info_outline,
                  color: currentColorScheme(context).onSurfaceVariant,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
