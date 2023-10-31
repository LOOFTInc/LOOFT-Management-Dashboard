/// Contains extensions for the [List<String>] class
extension StringListExtensions on List<String> {
  /// Toggles a value in the list
  /// If the value is present, it is removed
  /// If the value is not present, it is added
  List<String> toggle(String value) {
    if (contains(value)) {
      return List.from(this)..remove(value);
    } else {
      return List.from(this)..add(value);
    }
  }
}
