import 'package:cloud_functions/cloud_functions.dart';

/// Repository for Google Places API
class PlacesAPIRepository {
  /// Firebase Functions instance
  static FirebaseFunctions functions = FirebaseFunctions.instance;

  /// Get Auto Complete Suggestions
  static getAutoCompleteSuggestions({
    required String query,
  }) async {
    return await functions.httpsCallable('getAutoCompleteSuggestions').call({
      'query': query,
    });
  }

  /// Get Place Details
  static getPlaceDetails({
    required String placeID,
  }) async {
    return await functions.httpsCallable('getPlaceDetails').call({
      'placeID': placeID,
    });
  }

  /// Get Address From Lat Lng
  static getAddressFromLatLng({
    required double lat,
    required double lng,
  }) async {
    return await functions.httpsCallable('getAddressFromLatLng').call({
      'lat': lat,
      'lng': lng,
    });
  }
}
