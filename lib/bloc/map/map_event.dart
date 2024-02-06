part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class ZoomedIn extends MapEvent {}

class ZoomedOut extends MapEvent {}

class ChangedPositionAndZoom extends MapEvent {
  final LatLng center;
  final double zoom;
  ChangedPositionAndZoom(this.center, this.zoom);
}

class ChangedPosition extends MapEvent {
  final LatLng center;
  ChangedPosition(this.center);
}

class RequestedFitCameraToArea extends MapEvent {
  final List<LatLng> area;
  RequestedFitCameraToArea(this.area);
}
