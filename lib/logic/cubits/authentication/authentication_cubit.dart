import 'package:firebase_auth/firebase_auth.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/repositories/firebase/authentication_repository.dart';
import 'package:management_dashboard/helper_functions.dart';

part 'authentication_cubit.g.dart';
part 'authentication_state.dart';

/// The authentication cubit
class AuthenticationCubit extends HydratedCubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationState()) {
    loadCustomClaims();
  }

  /// Load the custom claims
  void loadCustomClaims() {
    state.user?.getIdTokenResult().then((value) {
      emit(state.copyWith(
        customClaims: value.claims,
        company: value.claims?['company'],
      ));
    });
  }

  /// Update the current company
  void updateCompany(String company) {
    emit(state.copyWith(company: company));
  }

  /// The authentication repository
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  /// Sign in with email and password
  /// returns null if successful, otherwise returns the error
  Future<String?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final result = await _authenticationRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (result is UserCredential) {
      emit(AuthenticationState(user: result.user!));
    } else {
      return _handleError(result);
    }

    return null;
  }

  /// Sign in with Google
  /// returns null if successful, otherwise returns an error message
  Future<String?> signInWithGoogle() async {
    GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
    googleAuthProvider.addScope('email');

    final result =
        await _authenticationRepository.signInWithGoogle(googleAuthProvider);

    if (result is UserCredential) {
      emit(AuthenticationState(user: result.user!));
    } else {
      return _handleError(result);
    }

    return null;
  }

  /// Sign up with email and password
  /// returns null if successful, otherwise returns an error message
  Future<String?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final result = await _authenticationRepository.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (result is UserCredential) {
      emit(AuthenticationState(user: result.user!));
    } else {
      return _handleError(result);
    }

    return null;
  }

  /// Send password reset email
  /// returns null if successful, otherwise returns an error message
  Future<String?> sendPasswordResetEmail({
    required String email,
  }) async {
    final result = await _authenticationRepository.sendPasswordResetEmail(
      email: email,
    );

    return _handleError(result);
  }

  /// Verify reset Password Code
  /// returns null if successful, otherwise returns an error message
  Future<String?> verifyResetPasswordCode({
    required String code,
  }) async {
    final result = await _authenticationRepository.verifyResetPasswordCode(
      code: code,
    );

    if (result != null) {
      if (result is FirebaseAuthException) {
        return result.message;
      } else {
        HelperFunctions.printDebug(result);
        return K.unexpectedError;
      }
    }

    return null;
  }

  /// Reset Password
  /// returns null if successful, otherwise returns an error message
  Future<String?> resetPassword({
    required String code,
    required String password,
  }) async {
    final result = await _authenticationRepository.resetPassword(
      code: code,
      password: password,
    );

    return _handleError(result);
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _authenticationRepository.signOut();
      emit(AuthenticationState());
    } catch (e) {
      HelperFunctions.handleFireStoreError(e);
    }
  }

  /// Handle error
  String? _handleError(dynamic result) {
    if (result != null) {
      if (result is FirebaseAuthException) {
        return result.message;
      } else {
        HelperFunctions.showUnexpectedError(result);
      }
    }

    return null;
  }

  /// Connect the generated [AuthenticationState.fromJson] function to the `fromJson`
  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) {
    return AuthenticationState.fromJson(json);
  }

  /// Connect the generated [AuthenticationState.toJson] function to the `toJson` method.
  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    return state.toJson();
  }
}
