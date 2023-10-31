part of 'iot_devices_list_bloc.dart';

@immutable
abstract class IoTDevicesListEvent {}

/// Event for when IoT Devices are loading
class IoTDevicesListLoadingEvent extends IoTDevicesListEvent {}

/// Event for when IoT Devices are updated
class IoTDevicesListUpdateEvent extends IoTDevicesListEvent {
  final List<IoTDevice> devices;

  IoTDevicesListUpdateEvent({required this.devices});
}

/// Event for when IoT Devices fail to load
class IoTDevicesListLoadingFailureEvent extends IoTDevicesListEvent {
  final String error;

  IoTDevicesListLoadingFailureEvent({required this.error});
}
