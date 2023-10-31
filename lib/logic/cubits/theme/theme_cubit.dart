import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/presentation/theming/custom_theme.dart';

part 'theme_cubit.g.dart';
part 'theme_state.dart';

/// The cubit for the theme
class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(ThemeState(themeMode: ThemeMode.dark));

  /// Sets the theme to dark mode
  void switchToDarkMode() {
    emit(state.copyWith(themeMode: ThemeMode.dark));
  }

  /// Sets the theme to light mode
  void switchToLightMode() {
    emit(state.copyWith(themeMode: ThemeMode.light));
  }

  /// Switches the theme
  void switchTheme() {
    if (state.themeMode == ThemeMode.dark) {
      switchToLightMode();
    } else {
      switchToDarkMode();
    }
  }

  /// Updates both the light theme and dark theme
  void updateThemes(
      {required ThemeData lightTheme, required ThemeData darkTheme}) {
    emit(state.copyWith(lightTheme: lightTheme, darkTheme: darkTheme));
  }

  /// Connect the generated [ThemeState.fromJson] function to the `fromJson`
  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState.fromJson(json);
  }

  /// Connect the generated [ThemeState.toJson] function to the `toJson` method.
  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toJson();
  }
}
