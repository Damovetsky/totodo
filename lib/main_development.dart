import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

import 'app.dart';
import 'init_main.dart';

void main() async {
  await initMain();
  FlavorConfig(
    name: 'DEV',
  );
  runApp(
    const App(),
  );
}
