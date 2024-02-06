import 'package:polaris_map_editor/models/place.dart';

/// Contract for a place repository.
abstract interface class PlaceRepository {
  /// Finds places based on the given query string.
  Future<List<Place>> findPlaces(String queryString);
}
