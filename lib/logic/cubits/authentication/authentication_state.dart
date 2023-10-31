part of 'authentication_cubit.dart';

/// The state of the authentication cubit
@JsonSerializable()
class AuthenticationState {
  /// The current user
  @JsonKey(includeFromJson: false, includeToJson: false)
  User? user;

  /// The custom claims of the user
  Map<String, dynamic>? customClaims;

  /// The company of the user
  String? company;

  AuthenticationState({
    this.user,
    this.customClaims,
    this.company,
  }) {
    user = FirebaseAuth.instance.currentUser;
  }

  /// Copy the current state with the given parameters
  AuthenticationState copyWith({
    User? user,
    Map<String, dynamic>? customClaims,
    String? company,
  }) {
    return AuthenticationState(
      user: user ?? this.user,
      customClaims: customClaims ?? this.customClaims,
      company: company ?? this.company,
    );
  }

  /// Connect the generated [_$AuthenticationStateFromJson] function to the `fromJson` factory.
  factory AuthenticationState.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationStateFromJson(json);

  /// Connect the generated [_$AuthenticationStateToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AuthenticationStateToJson(this);
}
