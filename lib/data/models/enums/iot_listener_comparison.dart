/// Class to use as the Comparison of the sensor value with the threshold
enum IoTListenerComparison {
  equalTo,
  greaterThan,
  lessThan,
  greaterThanOrEqualTo,
  lessThanOrEqualTo;

  /// Get the Comparison from String value
  static IoTListenerComparison fromStringSign(String value) {
    switch (value) {
      case '>':
        return IoTListenerComparison.greaterThan;
      case '<':
        return IoTListenerComparison.lessThan;
      case '>=':
        return IoTListenerComparison.greaterThanOrEqualTo;
      case '<=':
        return IoTListenerComparison.lessThanOrEqualTo;
      default:
        return IoTListenerComparison.equalTo;
    }
  }

  /// Get the Comparison from Display name
  static IoTListenerComparison fromStringDisplayName(String value) {
    switch (value) {
      case 'Equal to':
        return IoTListenerComparison.equalTo;
      case 'Greater than':
        return IoTListenerComparison.greaterThan;
      case 'Less than':
        return IoTListenerComparison.lessThan;
      case 'Greater than or equal to':
        return IoTListenerComparison.greaterThanOrEqualTo;
      case 'Less than or equal to':
        return IoTListenerComparison.lessThanOrEqualTo;
      default:
        return IoTListenerComparison.equalTo;
    }
  }
}

extension Sign on IoTListenerComparison {
  /// Converts Comparison enum to the corresponding sign
  String get sign {
    switch (this) {
      case IoTListenerComparison.equalTo:
        return '==';
      case IoTListenerComparison.greaterThan:
        return '>';
      case IoTListenerComparison.lessThan:
        return '<';
      case IoTListenerComparison.greaterThanOrEqualTo:
        return '>=';
      case IoTListenerComparison.lessThanOrEqualTo:
        return '<=';
    }
  }

  /// Get Text from Comparison
  String get displayName {
    switch (this) {
      case IoTListenerComparison.equalTo:
        return 'Equal to';
      case IoTListenerComparison.greaterThan:
        return 'Greater than';
      case IoTListenerComparison.lessThan:
        return 'Less than';
      case IoTListenerComparison.greaterThanOrEqualTo:
        return 'Greater than or equal to';
      case IoTListenerComparison.lessThanOrEqualTo:
        return 'Less than or equal to';
    }
  }
}
