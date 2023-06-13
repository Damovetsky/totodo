import 'package:flutter/material.dart';

import '../../core/ui/color_schemes.dart';
import '../../core/ui/dimentions.dart';
import '../../core/ui/text_styles.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentColorScheme(context).background,
      appBar: AppBar(
        backgroundColor: currentColorScheme(context).background,
        elevation: 0,
        scrolledUnderElevation: 4,
        leading: IconButton(
          splashRadius: 24,
          onPressed: () {},
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
                onPressed: () {},
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
                  horizontal: screenHorizontalMargin),
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
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: currentColorScheme(context).surface,
                        hintText: 'Что надо сделать…',
                        hintStyle: currentTextTheme(context)
                            .bodyMedium
                            ?.copyWith(
                                color: currentColorScheme(context)
                                    .onSurfaceVariant),
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
                      items: const <DropdownMenuItem>[
                        DropdownMenuItem(value: 'No', child: Text('Нет')),
                        DropdownMenuItem(value: 'Low', child: Text('Низкий')),
                        DropdownMenuItem(
                          value: 'High',
                          child: Text(
                            '!! Высокий',
                            style: TextStyle(color: redColor),
                          ),
                        ),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: currentColorScheme(context).onSurfaceVariant,
                  ),
                  const SizedBox(height: 4),
                  //Calendar
                  Row(
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
                            InkWell(
                              onTap: () {
                                showDatePicker(
                                  helpText: '',
                                  initialDatePickerMode: DatePickerMode.day,
                                  confirmText: 'ГОТОВО',
                                  cancelText: 'ОТМЕНА',
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2023),
                                  builder: (context, child) => Container(
                                    child: child,
                                  ),
                                  lastDate: DateTime(2024),
                                );
                              },
                              child: Text(
                                '2 июня 2021',
                                style: currentTextTheme(context)
                                    .labelLarge
                                    ?.copyWith(
                                      color:
                                          currentColorScheme(context).primary,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: false,
                        onChanged: (change) {},
                      )
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            Divider(
              thickness: 0.5,
              color: currentColorScheme(context).onSurfaceVariant,
            ),
            //Deete button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: screenHorizontalMargin,
              ),
              child: TextButton.icon(
                onPressed: () {},
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
