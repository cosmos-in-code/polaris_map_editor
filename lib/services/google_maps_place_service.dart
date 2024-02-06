import 'package:flutter/foundation.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:latlong2/latlong.dart';
import 'package:polaris_map_editor/contracts/place_repository.dart';
import 'package:polaris_map_editor/models/place.dart';

class GoogleMapsPlaceService implements PlaceRepository {
  final GoogleMapsPlaces googleMapsPlaces;

  const GoogleMapsPlaceService({
    required this.googleMapsPlaces,
  });

  @override
  Future<List<Place>> findPlaces(String queryString) async {
    final response = await googleMapsPlaces.searchByText(
      queryString,
      language: PlatformDispatcher.instance.locale.languageCode,
    );
    final places = response.results.where((place) => place.geometry != null);
    return places.map<Place>(
      (place) {
        return Place(
          name: place.name,
          address: place.formattedAddress ?? '',
          location: LatLng(
            place.geometry!.location.lat,
            place.geometry!.location.lng,
          ),
          iconImage: place.icon,
        );
      },
    ).toList();
  }
}
