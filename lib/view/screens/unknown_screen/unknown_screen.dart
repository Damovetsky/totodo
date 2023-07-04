import 'package:flutter/material.dart';

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO: add localization for this text
      appBar: AppBar(title: const Text('Задача не найдена')),
      body: const Center(
        child: Text('404'),
      ),
    );
  }
}
