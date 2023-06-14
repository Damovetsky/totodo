import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/ui/color_schemes.dart';
import '../../core/ui/dimentions.dart';
import '../../core/ui/text_styles.dart';
import '../../models/task.dart';
import '../../providers/tasks.dart';
import 'widgets/calendar_switch.dart';

class TaskDetailScreen extends StatelessWidget {
  static const routeName = '/task-detail';

  const TaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final task = ModalRoute.of(context)?.settings.arguments as Task?;
    final textController = TextEditingController(text: task?.description);
    Priority priority = Priority.none;
    DateTime? date;

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
                  ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButtonFormField(
                      style: currentTextTheme(context).bodyMedium,
                      decoration: InputDecoration(
                        enabled: false,
                        constraints: const BoxConstraints(maxWidth: 164),
                        disabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            style: BorderStyle.none,
                          ),
                        ),
                        contentPadding: const EdgeInsets.only(
                          top: 16,
                          bottom: 8,
                        ),
                        labelText: 'Важность',
                        labelStyle: currentTextTheme(context).headlineSmall,
                      ),
                      alignment: Alignment.centerLeft,
                      iconSize: 0,
                      hint: Text(
                        'Нет',
                        style: currentTextTheme(context).bodyMedium?.copyWith(
                              color:
                                  currentColorScheme(context).onSurfaceVariant,
                            ),
                      ),
                      value: task?.priority,
                      items: const <DropdownMenuItem>[
                        DropdownMenuItem(
                          value: Priority.none,
                          child: Text('Нет'),
                        ),
                        DropdownMenuItem(
                          value: Priority.low,
                          child: Text('Низкий'),
                        ),
                        DropdownMenuItem(
                          value: Priority.high,
                          child: Text(
                            '!! Высокий',
                            style: TextStyle(color: redColor),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        priority = value;
                      },
                    ),
                  ),
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
