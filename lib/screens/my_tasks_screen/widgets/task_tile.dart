import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/color_schemes.dart';
import '../../../core/ui/text_styles.dart';
import '../../../models/task.dart';
import '../../../providers/tasks.dart';
import '../../task_screen/task_detail_screen.dart';
import 'custom_checkbox.dart';

class TaskTile extends StatefulWidget {
  final Task task;

  const TaskTile({
    required this.task,
    super.key,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ru');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Tasks>(
      builder: (context, tasks, _) => Dismissible(
        key: ValueKey(widget.task.id),
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
              !widget.task.isChecked) {
            Provider.of<Tasks>(context, listen: false)
                .toggleTask(widget.task.id);
          }
        },
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            Provider.of<Tasks>(context, listen: false)
                .removeTask(widget.task.id);
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
              CustomCheckbox(task: widget.task),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: <TextSpan>[
                            if (widget.task.priority == Priority.high)
                              TextSpan(
                                text: '!! ',
                                style: TextStyle(
                                  fontSize: 20,
                                  height: 1,
                                  color: widget.task.isChecked
                                      ? greyColor
                                      : redColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            if (widget.task.priority == Priority.low)
                              const TextSpan(
                                text: '↓ ',
                                style: TextStyle(
                                  fontSize: 20,
                                  height: 1,
                                  color: greyColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            TextSpan(
                              text: widget.task.description,
                              style: widget.task.isChecked
                                  ? currentTextTheme(context)
                                      .bodyMedium
                                      ?.copyWith(
                                        color: currentColorScheme(context)
                                            .onSurfaceVariant,
                                        decoration: TextDecoration.lineThrough,
                                      )
                                  : currentTextTheme(context).bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      if (widget.task.dueDate != null)
                        Text(
                          DateFormat.yMMMMd('ru').format(widget.task.dueDate!),
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
                  Navigator.of(context).pushNamed(TaskDetailScreen.routeName,
                      arguments: widget.task);
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
