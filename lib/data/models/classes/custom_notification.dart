import '../enums/notification_types.dart';

/// Custom notification class
class CustomNotification {
  /// Text to be displayed in the notification
  String notificationText;

  /// Time of the notification
  DateTime when;

  /// Notification type
  NotificationTypes type;

  CustomNotification({
    required this.notificationText,
    required this.when,
    required this.type,
  });
}
