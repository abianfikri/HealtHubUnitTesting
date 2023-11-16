import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthhub/controller/userdata_controller.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setUpAll(() => {Firebase.initializeApp()});

  group('UserDataController', () {
    test('getDataBMI should return BMI data for a user', () async {
      // Arrange
      final UserDataController controller = UserDataController();
      final String userId = 'Fa28EpbR4SfjFEpIdKbhtDeSjID3';

      // Act
      final Map<String, dynamic> bmiData = await controller.getDataBMI(userId);

      // Assert
      expect(bmiData,
          isNotEmpty); // You can customize this assertion based on your data structure.
      // Add more specific assertions based on the expected data structure.
      // For example:
      expect(bmiData['uWeight'], isNotNull);
      expect(bmiData['uHeight'], isNotNull);
      // Add more assertions based on your data structure.

      // Cleanup (if needed)
      // You may want to clean up any test data created during the test.
    });

    // Add more tests as needed for other methods in UserDataController.
  });
}
