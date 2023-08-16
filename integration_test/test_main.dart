import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:totodo/app.dart';
import 'package:totodo/init_main.dart';

void main() async {
  await initMain();
  FlavorConfig(
    name: 'DEV',
  );
  runApp(
    const App(),
  );
}
