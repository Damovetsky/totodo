import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageFloatingActionButton extends StatelessWidget {
  const LanguageFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'Change language button',
      onPressed: () async {
        context.locale == const Locale('ru')
            ? context.setLocale(const Locale('en'))
            : context.setLocale(const Locale('ru'));
      },
      child: const Icon(Icons.language),
    );
  }
}
