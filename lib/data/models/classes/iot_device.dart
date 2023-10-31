import 'package:management_dashboard/data/models/classes/iot_device_listener_data.dart';

import 'custom_location.dart';
import 'iot_device_historical_data.dart';

/// IoT Device class
class IoTDevice {
  /// Name of the device
  String? deviceName;

  /// Mac address of the device
  String deviceID;

  /// Location of the device
  CustomLocation? location;

  /// Last time the IoT Device was updated
  DateTime? lastUpdated;

  /// Realtime data of the IoT Device
  Map<String, dynamic>? realtimeData;

  /// Device Serial Number
  String? serialNumber;

  /// Device Hardware Version
  String? hardwareVersion;

  /// Device Firmware Version
  String? firmwareVersion;

  /// Device Installed Date
  DateTime? installedDate;

  /// Historical data of the IoT Device
  IoTDeviceHistoricalData? historicalData;

  /// List of listeners for the IoT Device
  List<IoTDeviceListenerData>? listeners;

  /// Selected metrics for which the Graph is to be plotted
  List<String>? selectedMetrics;

  /// Selected metrics for which the Graph is to be plotted - this is for the second graph
  List<String>? selectedMetrics2;

  /// Template ID for this device
  String? deviceTemplateID;

  /// IoT Device constructor
  IoTDevice({
    this.deviceName,
    required this.deviceID,
    this.location,
    this.lastUpdated,
    this.realtimeData,
    this.serialNumber,
    this.hardwareVersion,
    this.firmwareVersion,
    this.installedDate,
    this.historicalData,
    this.selectedMetrics,
    this.selectedMetrics2,
    this.deviceTemplateID,
  }) {
    if (realtimeData != null) {
      updateRealtimeData(realtimeData!);
    }
  }

  /// IoT Device constructor from realtime data
  IoTDevice.fromRealtimeData({
    required this.deviceID,
    required this.realtimeData,
  }) {
    updateRealtimeData(realtimeData!);
  }

  /// Updates realtime data of the IoT Device
  /// and sets the status of the device
  /// based on the last updated time
  void updateRealtimeData(Map<String, dynamic> json) {
    realtimeData = json;
    lastUpdated = json['Time']?.toDate();
  }

  /// Loads Device data from Firebase JSON Object
  void loadDeviceDataFromFirebaseJson(Map<String, dynamic> json) {
    deviceName = json['deviceName'];
    deviceID = json['macAddress'];
    location = CustomLocation.fromMap(json['location']);
    serialNumber = json['serialNumber'];
    hardwareVersion = json['hardwareVersion'];
    firmwareVersion = json['firmwareVersion'];
    installedDate = json['installedDate']?.toDate();
    selectedMetrics = json['selectedMetrics'] == null
        ? null
        : List<String>.from(json['selectedMetrics']);
    selectedMetrics2 = json['selectedMetrics2'] == null
        ? null
        : List<String>.from(json['selectedMetrics2']);
    deviceTemplateID = json['deviceTemplateID'];
  }

  /// Converts IoTDevice to Firebase JSON Object
  Map<String, dynamic> toFirebaseJson() {
    return {
      'deviceName': deviceName,
      'macAddress': deviceID,
      'location': location?.toMap(),
      'serialNumber': serialNumber,
      'hardwareVersion': hardwareVersion,
      'firmwareVersion': firmwareVersion,
      'installedDate': installedDate,
      'selectedMetrics': selectedMetrics,
      'selectedMetrics2': selectedMetrics2,
      'deviceTemplateID': deviceTemplateID,
    };
  }
}
