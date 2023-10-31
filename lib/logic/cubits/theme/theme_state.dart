part of 'theme_cubit.dart';

/// The state for the theme cubit
class ThemeState {
  /// Current theme of the app
  ThemeMode themeMode;

  /// Dark theme for the app
  ThemeData darkTheme = CustomTheme.darkTheme;

  /// Light theme for the app
  ThemeData lightTheme = CustomTheme.lightTheme;

  // Following variables hold colors with opacity based on the theme
  // If the app is in light theme - all colors will have black as base color
  // If the app is in dark theme - all colors will have white as base color
  /// White/Black Color with 5% opacity
  late final Color opacity5;

  /// White/Black Color with 10% opacity
  late final Color opacity10;

  /// White/Black Color with 20% opacity
  late final Color opacity20;

  /// White/Black Color with 40% opacity
  late final Color opacity40;

  /// White/Black Color with 50% opacity
  late final Color opacity50;

  /// White/Black Color with 80% opacity
  late final Color opacity80;

  /// White/Black Color with 100% opacity
  late final Color opacity100;

  // Following variables hold colors with opacity based on the theme - REVERSED BASE COLOR
  // If the app is in light theme - all colors will have white as base color
  // If the app is in dark theme - all colors will have black as base color
  /// White/Black Color with 5% opacity
  late final Color reverseOpacity5;

  /// White/Black Color with 10% opacity
  late final Color reverseOpacity10;

  /// White/Black Color with 20% opacity
  late final Color reverseOpacity20;

  /// White/Black Color with 40% opacity
  late final Color reverseOpacity40;

  /// White/Black Color with 50% opacity
  late final Color reverseOpacity50;

  /// White/Black Color with 80% opacity
  late final Color reverseOpacity80;

  /// White/Black Color with 100% opacity
  late final Color reverseOpacity100;

  ThemeState({required this.themeMode}) {
    setOpacityColors();
  }

  /// Create a new state with the theme mode
  ThemeState.withThemeModes(
      {required this.themeMode,
      required this.lightTheme,
      required this.darkTheme}) {
    setOpacityColors();
  }

  /// Set the opacity colors based on the theme mode
  void setOpacityColors() {
    if (themeMode == ThemeMode.dark) {
      opacity5 = K.white5;
      opacity10 = K.white10;
      opacity20 = K.white20;
      opacity40 = K.white40;
      opacity50 = K.white50;
      opacity80 = K.white80;
      opacity100 = K.white;
      reverseOpacity5 = K.black5;
      reverseOpacity10 = K.black10;
      reverseOpacity20 = K.black20;
      reverseOpacity40 = K.black40;
      reverseOpacity50 = K.black50;
      reverseOpacity80 = K.black80;
      reverseOpacity100 = K.black;
    } else {
      opacity5 = K.black5;
      opacity10 = K.black10;
      opacity20 = K.black20;
      opacity40 = K.black40;
      opacity50 = K.black50;
      opacity80 = K.black80;
      opacity100 = K.black;
      reverseOpacity5 = K.white5;
      reverseOpacity10 = K.white10;
      reverseOpacity20 = K.white20;
      reverseOpacity40 = K.white40;
      reverseOpacity50 = K.white50;
      reverseOpacity80 = K.white80;
      reverseOpacity100 = K.white;
    }
  }

  /// Copy the current state with some changes
  ThemeState copyWith({
    ThemeMode? themeMode,
    ThemeData? lightTheme,
    ThemeData? darkTheme,
  }) {
    return ThemeState.withThemeModes(
      themeMode: themeMode ?? this.themeMode,
      lightTheme: lightTheme ?? this.lightTheme,
      darkTheme: darkTheme ?? this.darkTheme,
    );
  }

  /// Connect the generated [_$ThemeStateFromJson] function to the `fromJson`
  /// factory.
  factory ThemeState.fromJson(Map<String, dynamic> json) =>
      _$ThemeStateFromJson(json);

  /// Connect the generated [_$ThemeStateToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ThemeStateToJson(this);
}
