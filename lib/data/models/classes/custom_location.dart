import 'package:google_maps_flutter/google_maps_flutter.dart';

/// CustomLocation class
class CustomLocation {
  /// Latitude & Longitude of the device
  final LatLng latLng;

  /// Address of the location in string format
  final String? address;

  /// Location tag
  final String? tag;

  CustomLocation({
    this.address,
    required this.latLng,
    this.tag,
  });

  /// Converts CustomLocation to Map
  Map<String, dynamic> toMap() {
    return {
      'lat': latLng.latitude,
      'lon': latLng.longitude,
      'address': address,
      'tag': tag,
    };
  }

  /// Converts Map to CustomLocation
  factory CustomLocation.fromMap(Map<String, dynamic> map) {
    return CustomLocation(
      latLng: LatLng(map['lat'] as double, map['lon'] as double),
      address: map['address'] as String?,
      tag: map['tag'] as String?,
    );
  }
}
