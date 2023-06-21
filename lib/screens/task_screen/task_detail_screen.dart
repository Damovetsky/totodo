import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/ui/color_schemes.dart';
import '../../core/ui/dimentions.dart';
import '../../core/ui/text_styles.dart';
import '../../models/task.dart';
import '../../providers/tasks.dart';
import 'widgets/calendar_switch.dart';
import 'widgets/custom_dropdown_button.dart';

class TaskDetailScreen extends StatelessWidget {
  static const routeName = '/task-detail';

  const TaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final task = ModalRoute.of(context)?.settings.arguments as Task?;
    final textController = TextEditingController(text: task?.description);
    Priority priority = task?.priority ?? Priority.none;
    DateTime? date;

    void getPriority(Priority newPriority) {
      priority = newPriority;
    }

    void getDate(DateTime? newDate) {
      date = newDate;
    }

    return Scaffold(
      backgroundColor: currentColorScheme(context).background,
      appBar: AppBar(
        backgroundColor: currentColorScheme(context).background,
        elevation: 0,
        scrolledUnderElevation: 4,
        leading: IconButton(
          splashRadius: 24,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.close,
            color: currentColorScheme(context).onSurface,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: TextButton(
                onPressed: () {
                  if (task != null && textController.text.isNotEmpty) {
                    Provider.of<Tasks>(context, listen: false).updateTask(
                      task.id,
                      Task(
                        id: task.id,
                        description: textController.text,
                        createdAt: task.createdAt,
                        priority: priority,
                        isChecked: task.isChecked,
                        dueDate: date,
                      ),
                    );
                    Navigator.of(context).pop();
                  } else if (task == null && textController.text.isNotEmpty) {
                    Provider.of<Tasks>(context, listen: false).addTask(
                      Task(
                        id: DateTime.now().toString(),
                        description: textController.text,
                        createdAt: DateTime.now(),
                        priority: priority,
                        dueDate: date,
                      ),
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('СОХРАНИТЬ'),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: screenHorizontalMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    elevation: 2,
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: currentColorScheme(context).surface,
                        hintText: 'Что надо сделать…',
                        hintStyle: currentTextTheme(context)
                            .bodyMedium
                            ?.copyWith(
                              color:
                                  currentColorScheme(context).onSurfaceVariant,
                            ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      style: currentTextTheme(context).bodyMedium,
                      minLines: 4,
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  //Dropdown button
                  CustomDropdownButton(task: task, getPriority: getPriority),
                  Divider(
                    thickness: 0.5,
                    color: currentColorScheme(context).onSurfaceVariant,
                  ),
                  const SizedBox(height: 4),
                  //Calendar
                  CalendarSwitch(dueDate: task?.dueDate, getDate: getDate),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            Divider(
              thickness: 0.5,
              color: currentColorScheme(context).onSurfaceVariant,
            ),
            //Delete button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: screenHorizontalMargin,
              ),
              child: TextButton.icon(
                onPressed: task == null
                    ? null
                    : () {
                        Provider.of<Tasks>(context, listen: false)
                            .removeTask(task.id);
                        Navigator.of(context).pop();
                      },
                style: TextButton.styleFrom(
                  foregroundColor: currentColorScheme(context).error,
                  textStyle: currentTextTheme(context).bodyLarge,
                  disabledForegroundColor:
                      currentColorScheme(context).onSurfaceVariant,
                  padding: EdgeInsets.zero,
                ),
                icon: const Icon(
                  Icons.delete,
                ),
                label: const Text('Удалить'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
