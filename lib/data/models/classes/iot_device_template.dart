import 'package:management_dashboard/data/models/enums/device_template_device_types.dart';

import 'iot_device_template_metric.dart';

/// Template for defining IoT Device
class IoTDeviceTemplate {
  /// Firebase ID of the device Template
  String templateID;

  /// Name of the template
  String templateName;

  /// Device type
  DeviceTemplateDeviceTypes deviceType;

  /// Created date
  late final DateTime createdOn;

  /// Last Updated date
  late final DateTime lastUpdatedOn;

  /// List of metrics for the device
  List<IoTDeviceTemplateMetric> metrics;

  IoTDeviceTemplate({
    required this.templateID,
    required this.templateName,
    required this.deviceType,
    required this.metrics,
    DateTime? createdOn,
    DateTime? lastUpdatedOn,
  }) {
    this.createdOn = DateTime.now();
    this.lastUpdatedOn = DateTime.now();
  }

  /// Returns the map representation of the object
  Map<String, dynamic> toMap() {
    return {
      'templateName': templateName,
      'deviceType': deviceType.index,
      'metrics': metrics.map((e) => e.toMap()).toList(),
      'createdOn': createdOn,
      'lastUpdatedOn': lastUpdatedOn,
    };
  }

  /// Returns the object from the map
  factory IoTDeviceTemplate.fromFirebaseMap(
      Map<String, dynamic> map, String templateID) {
    return IoTDeviceTemplate(
      templateID: templateID,
      templateName: map['templateName'] as String,
      deviceType: DeviceTemplateDeviceTypes.values[map['deviceType']],
      metrics: map['metrics']
          .map<IoTDeviceTemplateMetric>(
              (e) => IoTDeviceTemplateMetric.fromMap(e))
          .toList(),
      createdOn: map['createdOn'].toDate(),
      lastUpdatedOn: map['lastUpdatedOn'].toDate(),
    );
  }

  /// Clone the template
  IoTDeviceTemplate clone() {
    return IoTDeviceTemplate(
      templateID: templateID,
      templateName: templateName,
      deviceType: deviceType,
      metrics: metrics.map((e) => e.clone()).toList(),
      createdOn: createdOn,
      lastUpdatedOn: lastUpdatedOn,
    );
  }
}
