import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../core/ui/color_schemes.dart';
import '../../../core/ui/dimentions.dart';
import '../../../core/ui/text_styles.dart';
import '../../../data/models/task.dart';
import '../../../generated/locale_keys.g.dart';
import '../../providers/tasks.dart';
import 'widgets/calendar_switch.dart';
import 'widgets/custom_dropdown_button.dart';

class TaskDetailScreen extends StatefulWidget {
  static const routeName = '/task-detail';

  const TaskDetailScreen({super.key});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  Task? argTask;
  late final TextEditingController textController;
  Priority priority = Priority.none;
  DateTime? date;

  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      argTask = ModalRoute.of(context)?.settings.arguments as Task?;
      textController = TextEditingController(text: argTask?.description);
      if (argTask != null) {
        priority = argTask!.priority;
        date = argTask!.dueDate;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges(Task? task) async {
    setState(() {
      _isLoading = true;
    });
    if (task != null) {
      await Provider.of<Tasks>(context, listen: false).updateTask(
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
    } else {
      await Provider.of<Tasks>(context, listen: false).addTask(
        Task(
          id: const Uuid().v4(),
          description: textController.text,
          createdAt: DateTime.now(),
          priority: priority,
          dueDate: date,
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final task = argTask;

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
              child: _isLoading
                  ? const Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: CircularProgressIndicator(),
                    )
                  : TextButton(
                      onPressed: () async {
                        if (textController.text.isNotEmpty) {
                          await _saveChanges(task);
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      child: Text(LocaleKeys.save.tr()),
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
                        hintText: LocaleKeys.what_needs_to_be_done.tr(),
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
                onPressed: task == null || _isLoading
                    ? null
                    : () async {
                        setState(() {
                          _isLoading = true;
                        });
                        await Provider.of<Tasks>(context, listen: false)
                            .removeTask(task.id);
                        setState(() {
                          _isLoading = false;
                        });
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
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
                label: Text(LocaleKeys.delete.tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
