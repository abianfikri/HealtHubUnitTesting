import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:healthhub/view/login.dart' as app;
import 'package:healthhub/view/dashboard.dart' as data;

Future main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    await Firebase.initializeApp();
  });
  group('"Login Test"', () {
    testWidgets('Verify Correct Username and Password to Login Screen',
        (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: app.LoginPage(),
      ));

      await widgetTester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.enterText(
          find.byType(TextFormField).at(0), 'zaki@zaki.com');

      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.enterText(
          find.byType(TextFormField).at(1), 'Zaki1234567@');

      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.tap(find.byType(ElevatedButton));
      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.pumpAndSettle();
      await widgetTester.pump();

      expect(find.byType(app.LoginPage), findsWidgets);
      await widgetTester.pump();

      await Future.delayed(const Duration(seconds: 2));
      expect(find.byType(data.DashboardView), findsWidgets);
    });
  });
}
