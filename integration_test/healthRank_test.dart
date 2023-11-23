import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthhub/view/dashboard.dart';
import 'package:healthhub/view/rank.dart';
import 'package:integration_test/integration_test.dart';

Future main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  setUp(() async => await Firebase.initializeApp());
  group('Healt Rank Test', () {
    testWidgets('Show Current User Rank', (widgetTester) async {
      await widgetTester.pump();
      await widgetTester.pumpWidget(MaterialApp(
        home: DashboardView(
            userId: 'iEYpkR2SFkfha961bO9r0AYc1ic2',
            bmiResult: '',
            bmiCategory: ''),
      ));

      await widgetTester.pump();

      await widgetTester.tap(find.text('Global Rank'));
      await widgetTester.pumpAndSettle();

      expect(find.byType(RankPage), findsWidgets);
      await widgetTester.pump();
    });
  });
}
