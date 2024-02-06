part of 'editor_bloc.dart';

@immutable
abstract class EditorEvent {}

class AddedPoint extends EditorEvent {
  final LatLng point;
  AddedPoint(this.point);
}

class DeletedPoint extends EditorEvent {
  final LatLng point;
  DeletedPoint(this.point);
}

class Undid extends EditorEvent {}

class Redid extends EditorEvent {}

class MovedPoint extends EditorEvent {
  final LatLng point;
  final LatLng newPosition;
  MovedPoint(this.point, this.newPosition);
}

class InsertedBetweenPoints extends EditorEvent {
  final List<LatLng> line;
  final LatLng point;

  InsertedBetweenPoints(this.line, this.point);
}

class DraggingPoint extends EditorEvent {
  final LatLng point;
  final LatLng newPosition;
  DraggingPoint(this.point, this.newPosition);
}

class StartedDraggingPointFromLine extends EditorEvent {
  final List<LatLng> line;
  final LatLng point;
  StartedDraggingPointFromLine(this.line, this.point);
}

class DraggingPointFromLine extends EditorEvent {
  final LatLng point;
  DraggingPointFromLine(this.point);
}

class DraggedPoint extends EditorEvent {
  DraggedPoint();
}
