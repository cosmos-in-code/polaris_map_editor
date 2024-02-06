import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:polaris_map_editor/contracts/place_repository.dart';
import 'package:polaris_map_editor/enums/status_fetch_data.dart';
import 'package:polaris_map_editor/models/place.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceRepository repository;
  int _version = 0;

  PlaceBloc({
    required this.repository,
  }) : super(const PlaceState()) {
    on<RequestedFindPlace>((event, emit) async {
      await _find(emit, state, event.queryString);
    });
    on<RetriedFindPlace>((event, emit) async {
      await _find(emit, state, state.queryString);
    });

    on<RequestedShowSearchPlacesField>((event, emit) {
      emit(state.copyWith(
        isShow: true,
      ));
    });

    on<RequestedHideSearchPlacesField>((event, emit) {
      emit(state.copyWith(
        isShow: false,
      ));
    });

    on<ToggledSearchPlacesVisibility>((event, emit) {
      if (state.isShow) {
        add(RequestedHideSearchPlacesField());
      } else {
        add(RequestedShowSearchPlacesField());
      }
    });

    on<ChangedText>((event, emit) {
      emit(state.copyWith(
        queryString: event.text,
      ));
    });
  }

  Future<void> _find(Emitter emit, PlaceState state, String queryString) async {
    emit(state.copyWith(
      queryString: queryString,
    ));

    if (queryString.isEmpty || queryString == state.queryString) {
      return;
    }

    emit(state.copyWith(
      status: StatusFetchData.fetching,
    ));
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
