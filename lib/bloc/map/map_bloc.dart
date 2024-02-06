import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapController mapController;

  MapBloc({
    required this.mapController,
  }) : super(MapState(mapController: mapController)) {
    on<RequestedFitCameraToArea>((event, emit) {
      mapController.fitCamera(CameraFit.bounds(
        bounds: LatLngBounds.fromPoints(event.area),
        padding: const EdgeInsets.all(100),
        maxZoom: 15,
      ));
    });

    on<ChangedPositionAndZoom>((event, emit) {
      mapController.move(event.center, event.zoom);
    });

    on<ZoomedIn>((event, emit) {
      mapController.move(
        mapController.camera.center,
        mapController.camera.zoom + 0.5,
      );
    });

    on<ZoomedOut>((event, emit) {
      mapController.move(
        mapController.camera.center,
        mapController.camera.zoom - 0.5,
      );
    });

    on<ChangedPosition>((event, emit) {
      mapController.move(event.center, mapController.camera.zoom);
    });
  }
}
