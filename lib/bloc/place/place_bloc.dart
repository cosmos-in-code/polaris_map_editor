import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:polaris_map_editor/contracts/place_repository.dart';
import 'package:polaris_map_editor/enums/status_fetch_data.dart';
import 'package:polaris_map_editor/models/place.dart';

part 'place_event.dart';
part 'place_state.dart';

/// Bloc for managing the state of places related to search and display.
class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  /// Repository for interacting with place data.
  final PlaceRepository repository;

  /// Counter to track versions of search requests.
  int _version = 0;

  /// Constructor to initialize the bloc with the repository instance.
  PlaceBloc({required this.repository}) : super(const PlaceState()) {
    // Handle events:

    // Event for requesting a place search with a new query string.
    on<RequestedFindPlace>((event, emit) async {
      await _find(emit, state, event.queryString);
    });

    // Event for retrying the previous place search.
    on<RetriedFindPlace>((event, emit) async {
      await _find(emit, state, state.queryString);
    });

    // Event for requesting to show the search places field.
    on<RequestedShowSearchPlacesField>((event, emit) {
      emit(state.copyWith(isShow: true));
    });

    // Event for requesting to hide the search places field.
    on<RequestedHideSearchPlacesField>((event, emit) {
      emit(state.copyWith(isShow: false));
    });

    // Event for toggling the visibility of the search places field.
    on<ToggledSearchPlacesVisibility>((event, emit) {
      if (state.isShow) {
        add(RequestedHideSearchPlacesField());
      } else {
        add(RequestedShowSearchPlacesField());
      }
    });
  }

  /// Private method to perform a place search and update the state accordingly.
  Future<void> _find(
    Emitter emit,
    PlaceState state,
    String queryString,
  ) async {
    emit(state.copyWith(queryString: queryString));

    if (queryString.isEmpty || queryString == state.queryString) {
      return;
    }

    emit(state.copyWith(status: StatusFetchData.fetching));
    int tmpVersion = ++_version;

    try {
      final places = await repository.findPlaces(queryString);

      if (tmpVersion != _version) {
        return;
      }

      emit(state.copyWith(
        queryString: queryString,
        status: StatusFetchData.fetched,
        places: places,
      ));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      if (tmpVersion != _version) {
        return;
      }

      emit(state.copyWith(
        status: StatusFetchData.error,
        error: e.toString(),
      ));
    }
  }
}
