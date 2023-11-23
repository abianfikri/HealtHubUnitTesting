import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthhub/view/target.dart' as app2;
import 'package:integration_test/integration_test.dart';
import 'package:healthhub/view/dashboard.dart' as app;

Future main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  setUp(() async => await Firebase.initializeApp());

  group('"BMI Calculator Test"', () {
    testWidgets('Calculate BMI, get recommendations, and save data',
        (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: app.DashboardView(
            userId: 'iEYpkR2SFkfha961bO9r0AYc1ic2',
            bmiCategory: '',
            bmiResult: ''),
      ));

      await widgetTester.pumpAndSettle();

      await widgetTester.tap(find.text('BMI Result'));
      await widgetTester.pumpAndSettle();

      // Ensure that the TargetPage is displayed
      expect(find.byType(app2.TargetPage), findsWidgets);

      // Enter weight and height
      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.enterText(find.byType(TextField).at(0), '70');
      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.enterText(find.byType(TextField).at(1), '175');

      // Tap on the Calculate button
      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.tap(find.widgetWithText(ElevatedButton, 'Calculate'));
      await widgetTester.pumpAndSettle();

      // Ensure that BMI and category are displayed
      await Future.delayed(const Duration(seconds: 2));
      expect(find.text('BMI Result:'), findsWidgets);
      await Future.delayed(const Duration(seconds: 2));
      expect(find.text('BMI Category:'), findsWidgets);

      // Tap on the Save button
      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.tap(find.widgetWithText(ElevatedButton, 'Save'));
      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.pump();
      await widgetTester.pump();
      await widgetTester.pump();
      await widgetTester.pump();

      // Ensure that the DashboardView is still displayed
      expect(find.byType(app.DashboardView), findsWidgets);
      // expect(find.text('BMI Data saved'), findsWidgets);
    });
  });
}
