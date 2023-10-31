import 'package:bloc/bloc.dart';
import 'package:management_dashboard/data/models/classes/iot_device.dart';
import 'package:management_dashboard/data/repositories/firebase/iot_devices_repository.dart';
import 'package:management_dashboard/helper_functions.dart';
import 'package:meta/meta.dart';

part 'iot_device_management_state.dart';

/// Cubit for IoT Device
class IoTDeviceManagementCubit extends Cubit<IoTDeviceManagementState> {
  IoTDeviceManagementCubit({required this.companyName})
      : super(IoTDeviceManagementInitial());

  /// Company Name
  final String companyName;

  /// IoT Devices Repository
  late final IoTDevicesRepository _iotDevicesRepository =
      IoTDevicesRepository(companyName: companyName);

  /// Deletes an IoT Device from Firebase
  Future<String?> deleteIoTDevice(IoTDevice device) async {
    try {
      return await _iotDevicesRepository.deleteIoTDevice(
        deviceID: device.deviceID,
      );
    } catch (e) {
      return HelperFunctions.handleFireStoreError(e);
    }
  }

  /// Updates an IoT Device in Firebase
  Future<String?> updateIoTDevice(IoTDevice device) async {
    try {
      return await _iotDevicesRepository
          .addOrUpdateIoTDevice(
            deviceID: device.deviceID,
            data: device.toFirebaseJson(),
          )
          .then((value) => null);
    } catch (e) {
      return HelperFunctions.handleFireStoreError(e);
    }
  }
}
