import 'package:flutter_google_maps_webservices/places.dart'; // Import for Google Maps Places API functionality
import 'package:polaris_map_editor/contracts/place_repository.dart'; // Import for PlaceRepository interface
import 'package:polaris_map_editor/services/google_maps_place_service.dart'; // Import for GoogleMapsPlaceService class

// Class for defining place search options in PolarisMapEditor
class PlaceOptions {
  // Property to hold a reference to the place repository
  PlaceRepository repository;

  // Factory constructor to create PlaceOptions with Google Maps Places API
  factory PlaceOptions.googleMapService({
    required String apiKey, // Required API key for Google Maps Places API
  }) {
    // Create a GoogleMapsPlaceService object with the provided API key
    return PlaceOptions(
      repository: GoogleMapsPlaceService(
        googleMapsPlaces: GoogleMapsPlaces(apiKey: apiKey),
      ),
    );
  }

  // Constructor for specifying a custom PlaceRepository (alternative to Google Maps service)
  PlaceOptions({
    required this.repository,
  });
}
