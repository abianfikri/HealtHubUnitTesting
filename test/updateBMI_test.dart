import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthhub/controller/userdata_controller.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  // Ensure Flutter is initialized before running any tests.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase before running tests.
  setUpAll(() {
    Firebase.initializeApp();
  });

  group('UserDataController Tests', () {
    test('updateBMI should update BMI data correctly', () async {
      // Arrange
      final userDataController = UserDataController();
      final String userId = 'Fa28EpbR4SfjFEpIdKbhtDeSjID3';
      final int weight = 70;
      final int height = 170;
      final double bmiResult = 24.2;
      final String bmiCategory = 'Normal';
      final int waterRecommendation = 2000;
      final int sleepRecommendation = 8;
      final int exerciseRecommendation = 30;
      final int calorieRecommendation = 2000;

      // Act
      await userDataController.updateBMI(
        userId,
        weight,
        height,
        bmiResult,
        bmiCategory,
        waterRecommendation,
        sleepRecommendation,
        exerciseRecommendation,
        calorieRecommendation,
      );

      // Assert
      final Map<String, dynamic> bmiData =
          await userDataController.getDataBMI(userId);

      expect(bmiData['uWeight'], equals(weight));
      expect(bmiData['uHeight'], equals(height));
      expect(bmiData['uBMIResult'], equals(bmiResult));
      expect(bmiData['uBMICategory'], equals(bmiCategory));
      expect(bmiData['uWaterRecomendation'], equals(waterRecommendation));
      expect(bmiData['uSleepRecomendation'], equals(sleepRecommendation));
      expect(bmiData['uExerciseRecomendation'], equals(exerciseRecommendation));
      expect(bmiData['uCalorieRecomendation'], equals(calorieRecommendation));
    });
  });
}
