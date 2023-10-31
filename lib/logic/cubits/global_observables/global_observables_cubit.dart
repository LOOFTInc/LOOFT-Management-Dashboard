import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'global_observables_cubit.g.dart';
part 'global_observables_state.dart';

class GlobalObservablesCubit extends HydratedCubit<GlobalObservablesState> {
  /// Global Observables Cubit
  GlobalObservablesCubit() : super(GlobalObservablesState());

  /// Appends a path to the current path in the app bar
  void appendToPath(String path) {
    List<String> newPath = List.from(state.appendToPath);
    newPath.add(path);

    emit(state.copyWith(appendToPath: newPath));
  }

  /// Removes the last path from the current path in the app bar
  void removeLastFromPath() {
    List<String> newPath = List.from(state.appendToPath);
    newPath.removeLast();

    emit(state.copyWith(appendToPath: newPath));
  }

  /// Toggles the day/night gradient
  void toggleDayNightGradient() {
    emit(state.copyWith(showDayNightGradient: !state.showDayNightGradient));
  }

  /// Toggles the graph difference highlight
  void toggleGraphDifferenceHighlight() {
    emit(state.copyWith(
        shouldHighlightGraphDifference: !state.shouldHighlightGraphDifference));
  }

  /// Selects the IoT Platform Analytics in the left bar
  void selectIoTPlatformAnalytics() {
    emit(state.copyWith(isIoTPlatformAnalyticsSelected: true));
  }

  /// Unselects the IoT Platform Analytics in the left bar
  void unselectIoTPlatformAnalytics() {
    emit(state.copyWith(isIoTPlatformAnalyticsSelected: false));
  }

  /// Sets the saved version
  void setSavedVersion(String savedVersion) {
    emit(state.copyWith(savedVersion: savedVersion));
  }

  /// Connect the generated [GlobalObservablesState.fromJson] function to the `fromJson`
  @override
  GlobalObservablesState? fromJson(Map<String, dynamic> json) {
    return GlobalObservablesState.fromJson(json);
  }

  /// Connect the generated [GlobalObservablesState.toJson] function to the `toJson` method.
  @override
  Map<String, dynamic>? toJson(GlobalObservablesState state) {
    return state.toJson();
  }
}
