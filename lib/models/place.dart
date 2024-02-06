import 'package:latlong2/latlong.dart';

/// Represents a place of interest with relevant information.

class Place {
  /// The name of the place.
  final String name;

  /// An optional description of the place.
  final String? description;

  /// The address of the place.
  final String address;

  /// The geographical coordinates of the place.
  final LatLng location;

  /// An optional URL to an image representing the place.
  final String? iconImage;

  /// Creates a Place instance with the specified details.
  const Place({
    required this.name,
    this.description,
    required this.address,
    required this.location,
    this.iconImage,
  });
}
