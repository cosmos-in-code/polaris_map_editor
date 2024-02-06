part of 'editor_bloc.dart';

/// Base class for all events related to the editor.
@immutable
abstract class EditorEvent {}

/// Event indicating a new point has been added at the given coordinates.
class AddedPoint extends EditorEvent {
  /// The geographical coordinates of the added point.
  final LatLng point;

  AddedPoint(this.point);
}

/// Event indicating an existing point has been removed.
class DeletedPoint extends EditorEvent {
  /// The geographical coordinates of the deleted point.
  final LatLng point;

  DeletedPoint(this.point);
}

/// Event indicating an undo action has been performed.
class Undid extends EditorEvent {}

/// Event indicating a redo action has been performed.
class Redid extends EditorEvent {}

/// Event indicating a point has been moved to a new position.
class MovedPoint extends EditorEvent {
  /// The original geographical coordinates of the point.
  final LatLng point;

  /// The new geographical coordinates of the point.
  final LatLng newPosition;

  MovedPoint(this.point, this.newPosition);
}

/// Event indicating a new point has been inserted between two existing points on a line.
class InsertedBetweenPoints extends EditorEvent {
  /// The line segment where the new point was inserted.
  final List<LatLng> line;

  /// The geographical coordinates of the inserted point.
  final LatLng point;

  InsertedBetweenPoints(this.line, this.point);
}

/// Event indicating a point is being dragged to a new position.
class DraggingPoint extends EditorEvent {
  /// The original geographical coordinates of the point.
  final LatLng point;

  /// The current geographical coordinates of the point during dragging.
  final LatLng newPosition;

  DraggingPoint(this.point, this.newPosition);
}

/// Event indicating dragging has started on a point that's part of a line.
class StartedDraggingPointFromLine extends EditorEvent {
  /// The line segment where the dragging started.
  final List<LatLng> line;

  /// The geographical coordinates of the point being dragged.
  final LatLng point;

  StartedDraggingPointFromLine(this.line, this.point);
}

/// Event indicating a point on a line is being dragged.
class DraggingPointFromLine extends EditorEvent {
  /// The current geographical coordinates of the point being dragged.
  final LatLng point;

  DraggingPointFromLine(this.point);
}

/// Event indicating a dragging operation has ended.
class DraggedPoint extends EditorEvent {}
