import 'package:management_dashboard/data/models/enums/account_roles.dart';

/// Class for user data
class CustomUser {
  final String uid;

  /// User email
  final String email;

  /// User display name
  final String? displayName;

  /// User photo URL
  final String? photoURL;

  /// User phone number
  final String? phoneNumber;

  /// User creation time
  final DateTime registrationDate;

  /// Custom claims
  final AccountRoles role;

  CustomUser({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoURL,
    required this.phoneNumber,
    required this.registrationDate,
    required this.role,
  });

  /// Convert from Firebase Json to CustomUser
  factory CustomUser.fromJson(Map<String, dynamic> json) {
    return CustomUser(
      uid: json['uid'],
      email: json['email'],
      displayName: json['name'],
      photoURL: json['photoURL'],
      phoneNumber: json['phoneNumber'],
      registrationDate: DateTime.parse(json['registrationDate']),
      role: AccountRoles.fromString(json['role']),
    );
  }
}
