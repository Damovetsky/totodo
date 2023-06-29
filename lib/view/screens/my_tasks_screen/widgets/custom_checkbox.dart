import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/ui/color_schemes.dart';
import '../../../../domain/models/task_model.dart';
import '../../../providers/tasks.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    super.key,
    required this.task,
  });

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (task.priority == Priority.high)
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              color: redColor.withOpacity(0.16),
              height: 18,
              width: 18,
            ),
          ),
        Checkbox(
          value: task.isChecked,
          activeColor: greenColor,
          fillColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return greenColor;
              }
              return task.priority == Priority.high
                  ? redColor
                  : currentColorScheme(context).onSurfaceVariant;
            },
          ),
          onChanged: (value) {
            Provider.of<Tasks>(context, listen: false).toggleTask(task.id);
          },
        ),
      ],
    );
  }
}
