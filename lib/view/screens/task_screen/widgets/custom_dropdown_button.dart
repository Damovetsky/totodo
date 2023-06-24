import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/color_schemes.dart';
import '../../../../core/ui/text_styles.dart';
import '../../../../data/models/task.dart';
import '../../../../generated/locale_keys.g.dart';

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
          labelText: LocaleKeys.priority.tr(),
          labelStyle: currentTextTheme(context).headlineSmall,
        ),
        alignment: Alignment.centerLeft,
        iconSize: 0,
        hint: Text(
          LocaleKeys.no_priority.tr(),
          style: currentTextTheme(context).bodyMedium?.copyWith(
                color: currentColorScheme(context).onSurfaceVariant,
              ),
        ),
        value: task?.priority,
        items: <DropdownMenuItem>[
          DropdownMenuItem(
            value: Priority.none,
            child: Text(LocaleKeys.no_priority.tr()),
          ),
          DropdownMenuItem(
            value: Priority.low,
            child: Text(LocaleKeys.low.tr()),
          ),
          DropdownMenuItem(
            value: Priority.high,
            child: Text(
              LocaleKeys.high.tr(),
              style: const TextStyle(color: redColor),
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
