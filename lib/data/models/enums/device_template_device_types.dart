import 'package:management_dashboard/data/models/extensions/string_extensions.dart';

enum DeviceTemplateDeviceTypes {
  iotDevice;
}

extension Name on DeviceTemplateDeviceTypes {
  String get displayName {
    switch (this) {
      case DeviceTemplateDeviceTypes.iotDevice:
        return 'IoT Device';
      default:
        return name.capitalizedCamelCase;
    }
  }
}
