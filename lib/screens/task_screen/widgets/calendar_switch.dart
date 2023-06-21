import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../core/ui/color_schemes.dart';
import '../../../core/ui/text_styles.dart';

class CalendarSwitch extends StatefulWidget {
  const CalendarSwitch({
    super.key,
    required this.dueDate,
    required this.getDate,
  });

  final DateTime? dueDate;
  final Function getDate;

  @override
  State<CalendarSwitch> createState() => _CalendarSwitchState();
}

class _CalendarSwitchState extends State<CalendarSwitch> {
  DateTime? date;

  @override
  void initState() {
    date = widget.dueDate;
    super.initState();
    initializeDateFormatting('ru');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Сделать до',
                style: currentTextTheme(context).bodyLarge,
              ),
              const SizedBox(
                height: 4,
              ),
              if (date != null)
                InkWell(
                  onTap: () async {
                    final newDate = await _showDatePicker(context, date);
                    if (newDate != null) {
                      setState(() {
                        date = newDate;
                        widget.getDate(date);
                      });
                    }
                  },
                  child: Text(
                    DateFormat.yMMMMd('ru').format(
                      date ?? DateTime.now(),
                    ),
                    style: currentTextTheme(context).labelLarge?.copyWith(
                          color: currentColorScheme(context).primary,
                        ),
                  ),
                ),
            ],
          ),
        ),
        Theme(
          data: Theme.of(context).copyWith(
            useMaterial3: false,
          ),
          child: Switch(
            value: date != null,
            onChanged: (change) async {
              if (date == null) {
                date = await _showDatePicker(context, date);
                widget.getDate(date);
                setState(() {});
              } else {
                setState(() {
                  date = null;
                });
                widget.getDate(date);
              }
            },
            activeColor: currentColorScheme(context).primary,
          ),
        )
      ],
    );
  }
}

Future<DateTime?> _showDatePicker(BuildContext context, DateTime? dueDate) {
  return showDatePicker(
    helpText: '',
    initialDatePickerMode: DatePickerMode.day,
    confirmText: 'ГОТОВО',
    cancelText: 'ОТМЕНА',
    context: context,
    initialDate: dueDate ?? DateTime.now(),
    firstDate: DateTime.now(),
    builder: (context, child) => Container(
      child: child,
    ),
    lastDate: DateTime(2024),
  );
}
