// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationState _$AuthenticationStateFromJson(Map<String, dynamic> json) =>
    AuthenticationState(
      customClaims: json['customClaims'] as Map<String, dynamic>?,
      company: json['company'] as String?,
    );

Map<String, dynamic> _$AuthenticationStateToJson(
        AuthenticationState instance) =>
    <String, dynamic>{
      'customClaims': instance.customClaims,
      'company': instance.company,
    };
