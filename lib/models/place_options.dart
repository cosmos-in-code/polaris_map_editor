import 'package:flutter_google_maps_webservices/places.dart';
import 'package:polaris_map_editor/contracts/place_repository.dart';
import 'package:polaris_map_editor/services/google_maps_place_service.dart';

class PlaceOptions {
  PlaceRepository repository;

  PlaceOptions.googleMapService({
    required String apiKey,
  }) : repository = GoogleMapsPlaceService(
          googleMapsPlaces: GoogleMapsPlaces(apiKey: apiKey),
        );

  PlaceOptions({
    required this.repository,
  });
}
