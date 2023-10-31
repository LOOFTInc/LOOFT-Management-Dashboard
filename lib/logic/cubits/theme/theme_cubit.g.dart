// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThemeState _$ThemeStateFromJson(Map<String, dynamic> json) => ThemeState(
      themeMode: json['name'] == 'dark' ? ThemeMode.dark : ThemeMode.light,
    );

Map<String, dynamic> _$ThemeStateToJson(ThemeState instance) =>
    <String, dynamic>{
      'name': instance.themeMode.name,
    };
