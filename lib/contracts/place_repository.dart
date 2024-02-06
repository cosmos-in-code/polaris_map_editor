import 'package:polaris_map_editor/models/place.dart';

abstract interface class PlaceRepository {
  Future<List<Place>> findPlaces(String queryString);
}
