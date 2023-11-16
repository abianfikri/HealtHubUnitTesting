import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:healthhub/controller/userdata_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase before running tests
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  group('UserDataController', () {
    test(
        'getAllUserNamesWithPoints should return a list of user names with points',
        () async {
      // Arrange
      final UserDataController controller = UserDataController();

      // Act
      final List<Map<String, dynamic>> userNamesWithPoints =
          await controller.getAllUserNamesWithPoints();

      // Assert
      expect(userNamesWithPoints, isList); // Ensure that the result is a list
      // Add more specific assertions based on the expected data structure.
      // For example:
      expect(userNamesWithPoints.isNotEmpty, true);
      expect(userNamesWithPoints.first, isMap);
      expect(userNamesWithPoints.first.containsKey('userName'), true);
      expect(userNamesWithPoints.first.containsKey('successPoint'), true);
      // Add more assertions based on your data structure.

      // Cleanup (if needed)
      // You may want to clean up any test data created during the test.
    });

    // Add more tests as needed for other methods in UserDataController.
  });
}
