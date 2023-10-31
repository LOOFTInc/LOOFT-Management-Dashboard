part of 'user_management_cubit.dart';

/// State of the [UserManagementCubit]
@immutable
sealed class UserManagementState {
  /// List of [CustomUser]s
  final List<CustomUser> users;

  const UserManagementState({this.users = const []});
}

/// Initial state of the [UserManagementCubit]
class UserManagementInitial extends UserManagementState {}

/// State of the [UserManagementCubit] when fetching users
class UsersListLoading extends UserManagementState {}

/// State of the [UserManagementCubit] when users are updated
class UsersListUpdated extends UserManagementState {
  final List<CustomUser> newUsers;

  const UsersListUpdated({required this.newUsers}) : super(users: newUsers);
}

/// State of the [UserManagementCubit] when users update is Failed
class UsersListUpdateFailed extends UserManagementState {
  final String error;

  const UsersListUpdateFailed({required this.error});
}
