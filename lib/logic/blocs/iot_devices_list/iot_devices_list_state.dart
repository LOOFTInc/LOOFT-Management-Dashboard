part of 'iot_devices_list_bloc.dart';

/// State for IoT Devices Bloc
sealed class IoTDevicesListState {
  /// List of IoT Devices
  final List<IoTDevice> devices;

  IoTDevicesListState({this.devices = const []});
}

/// Initial state for IoT Devices Bloc
class IoTDevicesListInitialState extends IoTDevicesListState {}

/// State for when IoT Devices are loading
class IoTDevicesListLoadingState extends IoTDevicesListState {
  IoTDevicesListLoadingState({super.devices});
}

/// State for when IoT Devices are updated
class IoTDevicesListUpdateState extends IoTDevicesListState {
  IoTDevicesListUpdateState({required super.devices});
}

/// State for when IoT Devices fail to load
class IoTDevicesListLoadingFailureState extends IoTDevicesListState {
  String? error;

  IoTDevicesListLoadingFailureState({super.devices, this.error});
}
