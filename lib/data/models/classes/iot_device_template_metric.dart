import 'package:management_dashboard/data/models/enums/device_template_capability_types.dart';
import 'package:management_dashboard/data/models/enums/device_template_semantic_types.dart';
import 'package:management_dashboard/data/models/enums/device_template_units.dart';
import 'package:management_dashboard/presentation/pages/dashboard/models/custom_colors.dart';

/// Template for defining IoT Device Metrics
class IoTDeviceTemplateMetric {
  /// Display name of the metric
  String displayName;

  /// Variable name of the metric
  String variableName;

  /// Capability type of the metric
  DeviceTemplateCapabilityTypes capabilityType;

  /// Semantic type of the metric
  DeviceTemplateSemanticTypes semanticType;

  /// Minimum value of the metric
  double? minValue;

  /// Maximum value of the metric
  double? maxValue;

  /// Unit of the metric
  DeviceTemplateUnits unit;

  /// Description of the metric
  String? description;

  /// Label of the metric
  String? label;

  /// Display unit of the metric
  String? displayUnit;

  /// Color of the metric
  CustomColors color;

  /// Whether to show the metric in realtime data widget
  bool showInRealtime;

  IoTDeviceTemplateMetric({
    required this.displayName,
    required this.variableName,
    required this.capabilityType,
    required this.semanticType,
    this.minValue,
    this.maxValue,
    required this.unit,
    this.description,
    this.label,
    this.displayUnit,
    required this.color,
    this.showInRealtime = true,
  });

  /// Returns the map representation of the object
  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'variableName': variableName,
      'capabilityType': capabilityType.index,
      'semanticType': semanticType.index,
      'minValue': minValue,
      'maxValue': maxValue,
      'unit': unit.index,
      'description': description,
      'label': label,
      'displayUnit': displayUnit,
      'color': color.index,
      'showInRealtime': showInRealtime,
    };
  }

  /// Returns the object from the map
  factory IoTDeviceTemplateMetric.fromMap(Map<String, dynamic> map) {
    return IoTDeviceTemplateMetric(
      displayName: map['displayName'] as String,
      variableName: map['variableName'] as String,
      capabilityType:
          DeviceTemplateCapabilityTypes.values[map['capabilityType']],
      semanticType: DeviceTemplateSemanticTypes.values[map['semanticType']],
      minValue: map['minValue'] as double?,
      maxValue: map['maxValue'] as double?,
      unit: DeviceTemplateUnits.values[map['unit']],
      description: map['description'] as String?,
      label: map['label'] as String?,
      displayUnit: map['displayUnit'] as String?,
      color: CustomColors.values[map['color']],
      showInRealtime: map['showInRealtime'] as bool,
    );
  }

  /// Returns the full name of the metric (label + display name)
  String getFullName() {
    return '${label != null ? '$label ' : ''}$displayName';
  }

  /// Clone the metric
  IoTDeviceTemplateMetric clone() {
    return IoTDeviceTemplateMetric(
      displayName: displayName,
      variableName: variableName,
      capabilityType: capabilityType,
      semanticType: semanticType,
      minValue: minValue,
      maxValue: maxValue,
      unit: unit,
      description: description,
      label: label,
      displayUnit: displayUnit,
      color: color,
      showInRealtime: showInRealtime,
    );
  }
}
