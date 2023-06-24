// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "my_tasks": "My tasks",
  "completed": "Completed — ",
  "new_task": "New task",
  "What_needs_to_be_done": "What needs to be done...",
  "priority": "Priority",
  "no_priority": "Default",
  "low": "Low",
  "high": "!! High",
  "save": "SAVE",
  "delete": "Delete",
  "do_before": "Do before",
  "cancel": "CANCEL",
  "done": "DONE"
};
static const Map<String,dynamic> ru = {
  "my_tasks": "Мои дела",
  "completed": "Выполнено — ",
  "new_task": "Новое",
  "what_needs_to_be_done": "Что надо сделать…",
  "priority": "Важность",
  "no_priority": "Нет",
  "low": "Низкий",
  "high": "!! Высокий",
  "save": "СОХРАНИТЬ",
  "delete": "Удалить",
  "do_before": "Сделать до",
  "cancel": "ОТМЕНА",
  "done": "ГОТОВО"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ru": ru};
}
