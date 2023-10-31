import 'package:management_dashboard/presentation/pages/dashboard/models/custom_colors.dart';

/// User roles enum
enum AccountRoles {
  /// Admin, has all permissions related to his Company
  admin,

  /// Manager, has all permissions related to his Company except for user management
  manager,

  /// Monitor, can only view data related to his Company
  monitor,

  /// IoT Device Account, can only write data to the relative documents in the Company's database
  iotDevice;

  /// Convert from String to UserRoles
  static AccountRoles fromString(String? value) {
    switch (value) {
      case 'admin':
        return AccountRoles.admin;
      case 'manager':
        return AccountRoles.manager;
      case 'monitor':
        return AccountRoles.monitor;
      case 'iot_device':
        return AccountRoles.iotDevice;
      default:
        return AccountRoles.monitor;
    }
  }
}

extension AccountRolesExtension on AccountRoles {
  /// Convert from UserRoles to String
  String get name {
    switch (this) {
      case AccountRoles.admin:
        return 'Admin';
      case AccountRoles.manager:
        return 'Manager';
      case AccountRoles.monitor:
        return 'Monitor';
      case AccountRoles.iotDevice:
        return 'IoT Device';
    }
  }

  /// Convert from UserRoles to Variable String
  String get variableName {
    switch (this) {
      case AccountRoles.admin:
        return 'admin';
      case AccountRoles.manager:
        return 'manager';
      case AccountRoles.monitor:
        return 'monitor';
      case AccountRoles.iotDevice:
        return 'iot_device';
    }
  }

  /// Convert from UserRoles to Color
  CustomColors get color {
    switch (this) {
      case AccountRoles.admin:
        return CustomColors.purple;
      case AccountRoles.manager:
        return CustomColors.orange;
      case AccountRoles.monitor:
        return CustomColors.green;
      case AccountRoles.iotDevice:
        return CustomColors.amber;
    }
  }

  /// Convert from UserRoles to Description
  String get description {
    switch (this) {
      case AccountRoles.admin:
        return 'Has permission to access and manage all data of the Company';
      case AccountRoles.manager:
        return 'Has permission to access and manage all data of the Company, except for user management';
      case AccountRoles.monitor:
        return 'View only, very limited access, no control';
      case AccountRoles.iotDevice:
        return 'Used for IoT Devices, Can only write data to the relative documents in the database';
    }
  }
}
