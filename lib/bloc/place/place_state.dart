part of 'place_bloc.dart';

/// Represents the state of the place search and display feature.
class PlaceState {
  /// Indicates whether the search places field is visible.
  final bool isShow;

  /// The current search query string entered by the user.
  final String queryString;

  /// The list of places retrieved from the search, or an empty list if none found.
  final List<Place> places;

  /// The current status of the search operation (initial, fetching, fetched, or error).
  final StatusFetchData status;

  /// An error message if the search operation failed, or null if successful.
  final String? error;

  /// Creates a PlaceState instance with the specified initial values.
  const PlaceState({
    this.isShow = false,
    this.queryString = '',
    this.places = const [],
    this.status = StatusFetchData.initial,
    this.error,
  });

  /// Creates a copy of the PlaceState with optional modifications.
  PlaceState copyWith({
    bool? isShow,
    String? queryString,
    List<Place>? places,
    StatusFetchData? status,
    String? error,
  }) {
    return PlaceState(
      isShow: isShow ?? this.isShow,
      queryString: queryString ?? this.queryString,
      places: places ?? this.places,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
