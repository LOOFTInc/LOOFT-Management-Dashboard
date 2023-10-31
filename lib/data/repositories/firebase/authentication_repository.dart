import 'package:firebase_auth/firebase_auth.dart';

/// Authentication Repository for Firebase
class AuthenticationRepository {
  /// Firebase Authentication instance
  final FirebaseAuth _firebaseAuth;

  AuthenticationRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  /// Sign in with email and password
  Future<dynamic> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => value);
    } catch (e) {
      return e;
    }
  }

  /// Sign in with Google
  Future<dynamic> signInWithGoogle(
      GoogleAuthProvider googleAuthProvider) async {
    try {
      return await _firebaseAuth
          .signInWithPopup(googleAuthProvider)
          .then((value) => value);
    } catch (e) {
      return e;
    }
  }

  /// Sign up with email and password
  Future<dynamic> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => value);
    } catch (e) {
      return e;
    }
  }

  /// Send password reset email
  Future<dynamic> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      return await _firebaseAuth
          .sendPasswordResetEmail(
            email: email,
          )
          .then((value) => null);
    } catch (e) {
      return e;
    }
  }

  /// Verify reset Password Code
  Future<dynamic> verifyResetPasswordCode({
    required String code,
  }) async {
    try {
      return await _firebaseAuth
          .verifyPasswordResetCode(
            code,
          )
          .then((value) => null);
    } catch (e) {
      return e;
    }
  }

  /// Reset Password
  Future<dynamic> resetPassword({
    required String code,
    required String password,
  }) async {
    try {
      return await _firebaseAuth
          .confirmPasswordReset(
            code: code,
            newPassword: password,
          )
          .then((value) => null);
    } catch (e) {
      return e;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
