// auth_controller_test.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthhub/controller/auth_controller.dart';
import 'package:healthhub/model/user_model.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockCollectionReference extends Mock implements CollectionReference {}

class MockDocumentReference extends Mock implements DocumentReference {}

class MockQuerySnapshot extends Mock implements QuerySnapshot {}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    // Initialize Firebase for tests
    await Firebase.initializeApp();
  });
  group('AuthController', () {
    late AuthController authController;
    late MockFirebaseAuth mockFirebaseAuth;
    late MockCollectionReference mockCollectionReference;
    late MockDocumentReference mockDocumentReference;
    late MockQuerySnapshot mockQuerySnapshot;
    late MockDocumentSnapshot mockDocumentSnapshot;
    late MockUserCredential mockUserCredential;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockCollectionReference = MockCollectionReference();
      mockDocumentReference = MockDocumentReference();
      mockQuerySnapshot = MockQuerySnapshot();
      mockDocumentSnapshot = MockDocumentSnapshot();
      mockUserCredential = MockUserCredential();

      authController = AuthController();
      authController.auth = mockFirebaseAuth;
      authController.usersCollection = mockCollectionReference;
    });

    test('signInWithEmailAndPassword - success', () async {
      // Arrange
      final String email = 'test@example.com';
      final String password = 'password123';

      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      )).thenAnswer((_) async => mockUserCredential);

      when(mockUserCredential.user).thenReturn(MockUser());
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get())
          .thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.exists).thenReturn(true);
      when(mockDocumentSnapshot.data()).thenReturn({
        'uId': 'testUserId',
        'uName': 'Test User',
        'uEmail': 'test@example.com',
        // Add other necessary fields
      });

      // Act
      final UserModel? result =
          await authController.signInWithEmailAndPassword(email, password);

      // Assert
      expect(result, isNotNull);
      // Add more assertions based on your expected results
    });

    test('signInWithEmailAndPassword - user not found', () async {
      // Arrange
      final String email = 'nonexistent@example.com';
      final String password = 'password123';

      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      )).thenAnswer((_) async => mockUserCredential);

      when(mockUserCredential.user).thenReturn(MockUser());
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get())
          .thenAnswer((_) async => mockDocumentSnapshot);
      when(mockDocumentSnapshot.exists).thenReturn(false);

      // Act
      final UserModel? result =
          await authController.signInWithEmailAndPassword(email, password);

      // Assert
      expect(result, isNull);
      // Add more assertions based on your expected results
    });

    // Add more test cases as needed
  });
}
