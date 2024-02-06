part of 'map_bloc.dart';

/// Base class for all events related to the map.
@immutable
abstract class MapEvent {}

/// Signals that the map has been zoomed in.
class ZoomedIn extends MapEvent {}

/// Signals that the map has been zoomed out.
class ZoomedOut extends MapEvent {}

/// Signals that the map's center position and zoom level have changed.
class ChangedPositionAndZoom extends MapEvent {
  /// The new center position of the map.
  final LatLng center;

  /// The new zoom level of the map.
  final double zoom;

  ChangedPositionAndZoom(this.center, this.zoom);
}

/// Signals that the map's center position has changed.
class ChangedPosition extends MapEvent {
  /// The new center position of the map.
  final LatLng center;

  ChangedPosition(this.center);
}

/// Signals a request to adjust the map camera to fit a given area.
class RequestedFitCameraToArea extends MapEvent {
  /// The area to fit within the map view.
  final List<LatLng> area;

  RequestedFitCameraToArea(this.area);
}
