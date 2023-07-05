import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../generated/locale_keys.g.dart';

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.task_not_found.tr())),
      body: const Center(
        child: Text('404'),
      ),
    );
  }
}
