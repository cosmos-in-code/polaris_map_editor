part of 'place_bloc.dart';

class PlaceState {
  final bool isShow;
  final String queryString;
  final List<Place> places;
  final StatusFetchData status;
  final String? error;

  const PlaceState({
    this.isShow = false,
    this.queryString = '',
    this.places = const [],
    this.status = StatusFetchData.initial,
    this.error,
  });

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
