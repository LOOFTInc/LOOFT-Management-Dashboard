enum SubscriptionTypes {
  lite,
  max,
}

extension Name on SubscriptionTypes {
  String get name {
    switch (this) {
      case SubscriptionTypes.lite:
        return 'Subscribed - LITE';
      case SubscriptionTypes.max:
        return 'Subscribed - MAX';
    }
  }
}
