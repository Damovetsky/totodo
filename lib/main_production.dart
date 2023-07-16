import 'package:flutter/material.dart';

import 'app.dart';
import 'init_main.dart';

void main() async {
  await initMain();
  runApp(
    const App(),
  );
}
