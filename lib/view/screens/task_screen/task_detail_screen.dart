import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../core/ui/color_schemes.dart';
import '../../../core/ui/dimentions.dart';
import '../../../core/ui/text_styles.dart';
import '../../../domain/models/task_model.dart';
import '../../../generated/locale_keys.g.dart';
import '../../providers/tasks.dart';
import 'widgets/calendar_switch.dart';
import 'widgets/custom_dropdown_button.dart';

class TaskDetailScreen extends StatefulWidget {
  static const routeName = '/task-detail';

  final TaskModel? task;

  const TaskDetailScreen({super.key, this.task});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late final TextEditingController textController;
  Priority priority = Priority.none;
  DateTime? date;

  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      textController = TextEditingController(text: widget.task?.description);
      if (widget.task != null) {
        priority = widget.task!.priority;
        date = widget.task!.dueDate;
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

  Future<void> _saveChanges(TaskModel? task) async {
    setState(() {
      _isLoading = true;
    });
    if (task != null) {
      await Provider.of<Tasks>(context, listen: false).updateTask(
        task.id,
        TaskModel(
          id: task.id,
          description: textController.text,
          createdAt: task.createdAt,
          priority: priority,
          isChecked: task.isChecked,
          dueDate: date,
          changedAt: DateTime.now(),
          deviceId: await getDeviceModel(),
        ),
      );
    } else {
      await Provider.of<Tasks>(context, listen: false).addTask(
        TaskModel(
          id: const Uuid().v4(),
          description: textController.text,
          createdAt: DateTime.now(),
          priority: priority,
          dueDate: date,
          changedAt: DateTime.now(),
          deviceId: await getDeviceModel(),
          isChecked: false,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;

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
                          _saveChanges(task);
                          Navigator.of(context).pop();
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

Future<String> getDeviceModel() async {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.model;
  }
  if (Platform.isIOS) {
    final iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor ?? 'unknown';
  }
  return 'unknown';
}
