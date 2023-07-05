import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:totodo/generated/locale_keys.g.dart';
import 'package:totodo/logger.dart';
import 'package:totodo/view/screens/task_screen/widgets/custom_dropdown_button.dart';

import 'test_main.dart' as test_app;

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => logger.i('Next test is running...'));

  testWidgets(
    'Add task test',
    (WidgetTester tester) async {
      test_app.main();
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.add), findsOneWidget);
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 1));

      await tester.enterText(
        find.byType(TextField).first,
        'Тест задача',
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CustomDropdownButton));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 1));

      await tester.tap(find.byKey(const ValueKey('high')));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 1));

      await tester.tap(find.text(LocaleKeys.save.tr()));
      await tester.pumpAndSettle();
    },
  );
}
