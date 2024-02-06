import 'package:latlong2/latlong.dart';

class Place {
  final String name;
  final String? description;
  final String address;
  final LatLng location;
  final String? iconImage;

  const Place({
    required this.name,
    this.description,
    required this.address,
    required this.location,
    this.iconImage,
  });
}
