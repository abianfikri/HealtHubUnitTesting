import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthhub/view/dashboard.dart';
import 'package:healthhub/view/exercise.dart';
import 'package:integration_test/integration_test.dart';

Future main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  setUp(() async => await Firebase.initializeApp());
  group('Exercise Test', () {
    testWidgets('Start can click', (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: DashboardView(
            userId: 'iEYpkR2SFkfha961bO9r0AYc1ic2',
            bmiResult: '',
            bmiCategory: ''),
      ));

      await widgetTester.pump();
      await widgetTester.pump();

      await widgetTester.tap(find.text('Exercise'));
      await widgetTester.pumpAndSettle();

      expect(find.byType(Exercise), findsWidgets);

      await widgetTester.pump();

      expect(find.text('Start'), findsOneWidget);

      await widgetTester.tap(find.widgetWithText(ElevatedButton, 'Start'));
      await widgetTester.pump();
      await widgetTester.pump(const Duration(seconds: 5));

      await widgetTester.pump();

      expect(find.text('Pause'), findsOneWidget);
      await widgetTester.tap(find.widgetWithText(ElevatedButton, 'Pause'));

      await widgetTester.pump();

      expect(find.text('Save'), findsOneWidget);
      await widgetTester.tap(find.widgetWithText(ElevatedButton, 'Save'));

      // Tap the save button.
      await widgetTester.tap(find.widgetWithText(ElevatedButton, 'Save'));
      await widgetTester.pump();
    });
  });
}
