/// Extension on String Class to capitalize
extension Capitalize on String {
  /// Convert camel case to capitalized and spaced string
  String get capitalizedCamelCase {
    return "${this[0].toUpperCase()}${substring(1)}"
        .replaceAllMapped(RegExp(r'[A-Z]'), (match) {
      return ' ${match.group(0)}';
    });
  }

  /// Convert first letter to capitalized
  String get capitalized {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
