part of 'place_bloc.dart';

/// Base class for all events related to place search and display.
@immutable
abstract class PlaceEvent {}

/// Event signaling a request to find places with a given query string.
class RequestedFindPlace extends PlaceEvent {
  /// The query string to use for searching places.
  final String queryString;

  /// Creates a RequestedFindPlace event with the given query string.
  RequestedFindPlace(this.queryString);
}

/// Event signaling a request to retry the previous place search.
class RetriedFindPlace extends PlaceEvent {}

/// Event signaling a request to show the search places field.
class RequestedShowSearchPlacesField extends PlaceEvent {}

/// Event signaling a request to hide the search places field.
class RequestedHideSearchPlacesField extends PlaceEvent {}

/// Event signaling a request to toggle the visibility of the search places field.
class ToggledSearchPlacesVisibility extends PlaceEvent {}
