import 'package:flutter/material.dart';

import '../../../models/task.dart';

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
  Widget build(BuildContext context) {
    final task = widget.task;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      constraints: const BoxConstraints(minHeight: 48, maxHeight: 84),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: task.isChecked,
            onChanged: (value) {
              setState(() {
                task.isChecked = value!;
              });
            },
          ),
          Expanded(
            child: Text(task.description),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info_outline),
          )
        ],
      ),
    );
  }
}
