// Import necessary libraries
import 'package:flutter/foundation.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:latlong2/latlong.dart';
import 'package:polaris_map_editor/contracts/place_repository.dart';
import 'package:polaris_map_editor/models/place.dart';

/// Define a class that implements the PlaceRepository interface
class GoogleMapsPlaceService implements PlaceRepository {
  /// Instance of GoogleMapsPlaces to interact with the API
  final GoogleMapsPlaces googleMapsPlaces;

  /// Constructor to initialize the service with the GoogleMapsPlaces instance
  const GoogleMapsPlaceService({
    required this.googleMapsPlaces,
  });

  /// Method to search for places based on a query string
  @override
  Future<List<Place>> findPlaces(String queryString) async {
    // Perform the search using the GoogleMapsPlaces API
    final response = await googleMapsPlaces.searchByText(
      queryString,
      language: PlatformDispatcher.instance.locale.languageCode,
    );

    // Filter the results to those with valid geometry data
    final places = response.results.where((place) => place.geometry != null);

    // Convert the filtered results to Place objects
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
