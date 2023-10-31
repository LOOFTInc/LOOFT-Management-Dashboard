part of 'iot_device_templates_cubit.dart';

/// State of the [IoTDeviceTemplatesCubit]
sealed class IoTDeviceTemplatesState {
  /// List of [IoTDeviceTemplate]s
  List<IoTDeviceTemplate> deviceTemplates;

  /// Default template ID
  String? defaultTemplateID;

  IoTDeviceTemplatesState({
    this.defaultTemplateID,
    this.deviceTemplates = const [],
  });

  /// Returns a copy of the state
  IoTDeviceTemplatesState copyWith({
    List<IoTDeviceTemplate>? deviceTemplates,
    String? defaultTemplateID,
  }) {
    return IoTDeviceTemplatesUpdateState(
      deviceTemplates: deviceTemplates ?? this.deviceTemplates,
      defaultTemplateID: defaultTemplateID ?? this.defaultTemplateID,
    );
  }
}

/// Initial state of the [IoTDeviceTemplatesCubit]
class IoTDeviceTemplatesInitialState extends IoTDeviceTemplatesState {}

/// State for when the [IoTDeviceTemplate]s are loading
class IoTDeviceTemplatesLoadingState extends IoTDeviceTemplatesState {}

/// State for when the [IoTDeviceTemplate]s are updated
class IoTDeviceTemplatesUpdateState extends IoTDeviceTemplatesState {
  IoTDeviceTemplatesUpdateState(
      {required super.deviceTemplates, super.defaultTemplateID});
}
