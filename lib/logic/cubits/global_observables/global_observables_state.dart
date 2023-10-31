part of 'global_observables_cubit.dart';

/// The state for the global observables cubit
@JsonSerializable()
class GlobalObservablesState {
  /// The path to append to the current path in the app bar
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String> appendToPath;

  /// Is the day/night gradient visible
  bool showDayNightGradient;

  /// Should the graph difference be highlighted
  bool shouldHighlightGraphDifference;

  /// Is the IoT Platform Analytics selected in the left bar
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool isIoTPlatformAnalyticsSelected;

  /// The saved version of the app
  final String? savedVersion;

  /// Constructor
  GlobalObservablesState({
    this.appendToPath = const <String>[],
    this.showDayNightGradient = false,
    this.shouldHighlightGraphDifference = true,
    this.isIoTPlatformAnalyticsSelected = false,
    this.savedVersion,
  });

  /// Copy the current state with some changes
  GlobalObservablesState copyWith({
    List<String>? appendToPath,
    bool? showDayNightGradient,
    bool? shouldHighlightGraphDifference,
    bool? isIoTPlatformAnalyticsSelected,
    String? savedVersion,
  }) {
    return GlobalObservablesState(
      appendToPath: appendToPath ?? this.appendToPath,
      showDayNightGradient: showDayNightGradient ?? this.showDayNightGradient,
      shouldHighlightGraphDifference:
          shouldHighlightGraphDifference ?? this.shouldHighlightGraphDifference,
      isIoTPlatformAnalyticsSelected:
          isIoTPlatformAnalyticsSelected ?? this.isIoTPlatformAnalyticsSelected,
      savedVersion: savedVersion ?? this.savedVersion,
    );
  }

  /// Connect the generated [_$GlobalObservablesStateFromJson] function to the `fromJson` factory.
  factory GlobalObservablesState.fromJson(Map<String, dynamic> json) =>
      _$GlobalObservablesStateFromJson(json);

  /// Connect the generated [_$GlobalObservablesStateToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GlobalObservablesStateToJson(this);
}
