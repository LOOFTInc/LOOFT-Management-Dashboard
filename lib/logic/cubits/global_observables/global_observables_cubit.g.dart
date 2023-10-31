// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_observables_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlobalObservablesState _$GlobalObservablesStateFromJson(
        Map<String, dynamic> json) =>
    GlobalObservablesState(
      showDayNightGradient: json['showDayNightGradient'] as bool? ?? false,
      shouldHighlightGraphDifference:
          json['shouldHighlightGraphDifference'] as bool? ?? true,
      savedVersion: json['savedVersion'] as String?,
    );

Map<String, dynamic> _$GlobalObservablesStateToJson(
        GlobalObservablesState instance) =>
    <String, dynamic>{
      'showDayNightGradient': instance.showDayNightGradient,
      'shouldHighlightGraphDifference': instance.shouldHighlightGraphDifference,
      'savedVersion': instance.savedVersion,
    };
