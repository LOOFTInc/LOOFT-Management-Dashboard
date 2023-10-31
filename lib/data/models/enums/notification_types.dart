enum NotificationTypes {
  bug,
  customer,
  subscription,
}

extension Icons on NotificationTypes {
  String get iconSvgPath {
    const String parentPath = 'assets/icons/';

    switch (this) {
      case NotificationTypes.bug:
        return '${parentPath}bug.svg';
      case NotificationTypes.customer:
        return '${parentPath}customer.svg';
      case NotificationTypes.subscription:
        return '${parentPath}broadcast.svg';
      default:
        return '${parentPath}bell.svg';
    }
  }
}
