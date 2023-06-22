import 'package:flutter/material.dart';

import '../../../../core/ui/color_schemes.dart';
import '../../../../core/ui/text_styles.dart';
import '../../../../data/models/task.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    super.key,
    required this.task,
    required this.getPriority,
  });

  final Task? task;
  final Function getPriority;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
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
                color: currentColorScheme(context).onSurfaceVariant,
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
          getPriority(value);
        },
      ),
    );
  }
}
