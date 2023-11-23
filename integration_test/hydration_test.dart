import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthhub/view/dashboard.dart';
import 'package:healthhub/view/hydration.dart' as app;
import 'package:integration_test/integration_test.dart';

Future main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async => {await Firebase.initializeApp()});
  group('Hydration test widget', () {
    testWidgets('Add Water Daily', (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: DashboardView(
            userId: 'iEYpkR2SFkfha961bO9r0AYc1ic2',
            bmiResult: '',
            bmiCategory: ''),
      ));

      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.text('Hydration'));
      await widgetTester.pumpAndSettle();

      // Ensure that the Hydration is displayed
      expect(find.byType(app.Hydration), findsWidgets);

      await widgetTester.pump();

      // Tap the add button five times.
      for (int i = 0; i < 5; i++) {
        await widgetTester.tap(find.byIcon(Icons.add));
        await widgetTester.pump();
        await widgetTester.pump(const Duration(
            milliseconds: 500)); // Wait for animation to complete.
      }

      await widgetTester.pump();

      // Verify that the save button is enabled (assuming it's initially disabled when water intake is 0).
      expect(find.byType(ElevatedButton), findsOneWidget);

      // Tap the save button.
      await widgetTester.tap(find.byType(ElevatedButton));
      await widgetTester.pump();
    });
  });
}
