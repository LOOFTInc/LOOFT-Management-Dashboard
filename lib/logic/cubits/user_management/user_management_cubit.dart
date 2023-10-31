import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:management_dashboard/data/models/classes/custom_user.dart';
import 'package:management_dashboard/data/models/enums/account_roles.dart';
import 'package:management_dashboard/data/repositories/firebase/user_management_repository.dart';
import 'package:management_dashboard/helper_functions.dart';
import 'package:management_dashboard/logic/cubits/authentication/authentication_cubit.dart';
import 'package:meta/meta.dart';

part 'user_management_state.dart';

/// Cubit for managing users
class UserManagementCubit extends Cubit<UserManagementState> {
  UserManagementCubit() : super(UserManagementInitial());

  /// Initializes the cubit
  void initCubit({
    required AuthenticationCubit authenticationCubit,
  }) {
    if (state is UserManagementInitial ||
        authenticationCubit.state.user?.uid !=
            _authenticationState?.user?.uid) {
      _userManagementRepository = UserManagementRepository(
        companyName: authenticationCubit.state.company!,
      );
      _authenticationState = authenticationCubit.state;

      fetchAllUsers();
    }
  }

  /// User Management Repository
  UserManagementRepository? _userManagementRepository;

  /// Authentication State
  AuthenticationState? _authenticationState;

  /// Default error message
  final String defaultError = 'Failed to fetch users. Please Retry!';

  /// Fetch all users
  Future<void> fetchAllUsers() async {
    final String? currentUserRole = _authenticationState?.customClaims?['role'];

    if (currentUserRole != 'admin' && currentUserRole != 'super_admin') {
      emit(const UsersListUpdateFailed(
          error: 'You are not authorized to perform this action'));
      return;
    }

    if (_authenticationState?.company == null) {
      emit(const UsersListUpdateFailed(error: 'Company not found'));
      return;
    }

    emit(UsersListLoading());
    try {
      await _userManagementRepository?.fetchAllUsers().then((result) {
        final String? error = HelperFunctions.handleCloudFunctionsResult(result,
            defaultErrorMessage: defaultError);
        if (error != null) {
          emit(UsersListUpdateFailed(error: error));
          return;
        } else {
          final List<CustomUser> users = result['result']
              .map<CustomUser>((user) => CustomUser.fromJson(user))
              .toList();

          emit(UsersListUpdated(newUsers: users));
        }
      });
    } catch (e) {
      emit(UsersListUpdateFailed(
          error: HelperFunctions.handleFireStoreError(e,
                  defaultErrorMessage: defaultError) ??
              defaultError));
    }
  }

  /// Add a new user
  Future<String?> addUser({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
    required AccountRoles role,
    PlatformFile? image,
  }) async {
    final String? currentUserRole = _authenticationState?.customClaims?['role'];

    if (currentUserRole != 'admin' && currentUserRole != 'super_admin') {
      return 'You are not authorized to perform this action';
    }

    if (_authenticationState?.company == null) {
      return 'Company not found';
    }

    try {
      return await _userManagementRepository
          ?.createUser(
        email: email,
        password: password,
        name: fullName,
        phoneNumber: phoneNumber,
        role: role.variableName,
        image: image,
      )
          .then((result) {
        final String? error = HelperFunctions.handleCloudFunctionsResult(result,
            defaultErrorMessage: defaultError);
        if (error != null) {
          return error;
        } else {
          final List<CustomUser> users = List.from(state.users)
            ..add(CustomUser.fromJson(result['result']));

          emit(UsersListUpdated(newUsers: users));
        }

        return null;
      });
    } catch (e) {
      return HelperFunctions.handleFireStoreError(e,
          defaultErrorMessage: 'Failed to add user. Please Retry!');
    }
  }

  /// Update a user
  Future<String?> updateUser({
    required String uid,
    required String email,
    String? password,
    required String fullName,
    String? phoneNumber,
    required AccountRoles role,
    PlatformFile? image,
    String? imageURL,
  }) async {
    final String? currentUserRole = _authenticationState?.customClaims?['role'];

    if (currentUserRole != 'admin' && currentUserRole != 'super_admin') {
      return 'You are not authorized to perform this action';
    }

    if (_authenticationState?.company == null) {
      return 'Company not found';
    }

    try {
      return await _userManagementRepository
          ?.updateUser(
        uid: uid,
        email: email,
        password: password,
        name: fullName,
        phoneNumber: phoneNumber,
        role: role.variableName,
        image: image,
        photoURL: imageURL,
      )
          .then((result) {
        final String? error = HelperFunctions.handleCloudFunctionsResult(result,
            defaultErrorMessage: defaultError);
        if (error != null) {
          return error;
        } else {
          final List<CustomUser> users = List.from(state.users);
          final int index = users.indexWhere((user) => user.uid == uid);
          users[index] = CustomUser.fromJson(result['result']);

          emit(UsersListUpdated(newUsers: users));
        }

        return null;
      });
    } catch (e) {
      return HelperFunctions.handleFireStoreError(e,
          defaultErrorMessage: 'Failed to update user. Please Retry!');
    }
  }

  /// Delete a user
  Future<String?> deleteUser({
    required CustomUser user,
  }) async {
    final String? currentUserRole = _authenticationState?.customClaims?['role'];

    if (currentUserRole != 'admin' && currentUserRole != 'super_admin') {
      return 'You are not authorized to perform this action';
    }

    if (_authenticationState?.company == null) {
      return 'Company not found';
    }

    try {
      return await _userManagementRepository
          ?.deleteUser(
        photoURL: user.photoURL,
        uid: user.uid,
      )
          .then((result) {
        final String? error = HelperFunctions.handleCloudFunctionsResult(result,
            defaultErrorMessage: defaultError);
        if (error != null) {
          return error;
        } else {
          final List<CustomUser> users = List.from(state.users);
          users.removeWhere((element) => element.uid == user.uid);

          emit(UsersListUpdated(newUsers: users));
        }

        return null;
      });
    } catch (e) {
      return HelperFunctions.handleFireStoreError(e,
          defaultErrorMessage: 'Failed to delete user. Please Retry!');
    }
  }
}
