import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:healthhub/view/login.dart' as app1;
import 'package:healthhub/view/register.dart' as app2;

Future main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async => await Firebase.initializeApp());

  group('Register Test', () {
    testWidgets('Register Correct', (WidgetTester widgetTester) async {
      // Navigate to LoginView
      await widgetTester.pumpWidget(MaterialApp(
        home: app1.LoginPage(),
      ));

      // Tap the TextButton to navigate to RegisterView
      await widgetTester.tap(find.byType(TextButton));
      await widgetTester.pumpAndSettle();

      // Verify navigation to RegisterView
      expect(find.byType(app2.RegisterView), findsOneWidget);

      // Fill in the registration form
      await widgetTester.enterText(
          find.byType(TextFormField).at(0), 'fatika12'); // Name
      await widgetTester.enterText(
          find.byType(TextFormField).at(1), 'fatika1@fatika1.com'); // Email
      await widgetTester
          .tap(find.byType(DropdownButtonFormField<String>)); // Gender
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('Male'));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(OutlinedButton)); // Date of Birth
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.text('OK'));
      await widgetTester.pumpAndSettle();
      await widgetTester.enterText(
          find.byType(TextFormField).at(2), 'password123'); // Password
      await widgetTester.enterText(
          find.byType(TextFormField).at(3), 'password123'); // Re-Password

      // Tap Register Button
      await widgetTester.tap(find.byType(ElevatedButton));
      await widgetTester.pumpAndSettle();

      // Verify alert dialog
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Registration Successful'), findsOneWidget);
      await widgetTester.pump();

      // Tap OK on the alert dialog
      await widgetTester.tap(find.text('OK'));
      await widgetTester.pumpAndSettle();

      await widgetTester.pump();

      // Verify navigation to LoginView
      // Verify navigation to LoginView
      expect(find.byType(app2.RegisterView), findsOneWidget);
      await widgetTester.pump();
      expect(find.byType(app1.LoginPage), findsOneWidget);
      await widgetTester.pump();
    });
  });
}
