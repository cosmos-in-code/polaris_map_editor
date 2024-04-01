import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'package:polaris_map_editor/enums/drag_type.dart';
import 'package:polaris_map_editor/models/drag.dart';
import 'package:polaris_map_editor/support/helpers.dart';

part 'editor_event.dart';
part 'editor_state.dart';

/// A BLoC for managing the state of an editor for editing points on a map.
class EditorBloc extends Bloc<EditorEvent, EditorState> {
  // Store the line stroke width for calculations.
  final double lineStrokeWidth;

  EditorBloc({
    required List<LatLng> initialArea,
    required this.lineStrokeWidth,
  }) : super(
          initialArea.isNotEmpty
              ? EditorState(snapshots: [Editor(initialArea)])
              : const EditorState(),
        ) {
    on<AddedPoint>((event, emit) {
      if (_isPointOnLine(event.point)) {
        return;
      }

      emit(state.copyWith(
        snapshots: [
          ...state.snapshots,
          _createSnapshot(event.point),
        ],
        clearFowardSnapshots: true,
      ));
    });

    on<DeletedPoint>((event, emit) {
      final current = state.snapshots.last;
      final newSnapshot = current.copy();

      for (var i = 0; i < current.points.length; i++) {
        if (current.points[i] == event.point) {
          newSnapshot.points.removeAt(i);
          break;
        }
      }

      emit(state.copyWith(
        snapshots: [
          ...state.snapshots,
          newSnapshot,
        ],
        clearFowardSnapshots: true,
      ));
    });

    on<Undid>((event, emit) {
      if (state.snapshots.length > 1) {
        final newSnapshots =
            state.snapshots.sublist(0, state.snapshots.length - 1);
        final forwardSnapshots = [...state.fowardSnapshots];

        forwardSnapshots.add(state.snapshots.last);

        emit(state.copyWith(
          snapshots: newSnapshots,
          fowardSnapshots: forwardSnapshots,
          clearFowardSnapshots: false,
        ));
      }
    });

    on<Redid>((event, emit) {
      if (state.fowardSnapshots.isNotEmpty) {
        final newSnapshots = [...state.snapshots, state.fowardSnapshots.last];
        final forwardSnapshots =
            state.fowardSnapshots.sublist(0, state.fowardSnapshots.length - 1);

        emit(state.copyWith(
          snapshots: newSnapshots,
          fowardSnapshots: forwardSnapshots,
          clearFowardSnapshots: false,
        ));
      }
    });

    on<DraggingPoint>((event, emit) {
      emit(state.copyWith(
        dragging: Drag.fromPoint(
          event.point,
          event.newPosition,
        ),
        clearFowardSnapshots: true,
      ));
    });

    on<StartedDraggingPointFromLine>((event, emit) {
      if (isPointOnLine(event.line[0], event.line[1], event.point,
          strokeWidth: lineStrokeWidth)) {
        emit(state.copyWith(
          dragging: Drag.fromLine(
            event.line,
            event.point,
          ),
        ));
      }
    });

    on<DraggingPointFromLine>((event, emit) {
      if (state.dragging != null) {
        emit(state.copyWith(
          dragging: state.dragging!.copyWith(
            destination: event.point,
          ),
          clearFowardSnapshots: true,
        ));
      }
    });

    on<DraggedPoint>((event, emit) {
      final dragginState = state.dragging;

      emit(state.copyWith(
        stopDragging: true,
        clearFowardSnapshots: true,
      ));

      if (dragginState != null && !_isPointOnLine(dragginState.destination)) {
        if (dragginState.type == DragType.fromPoint) {
          add(MovedPoint(dragginState.originPoint!, dragginState.destination));
        } else if (dragginState.type == DragType.fromLine) {
          add(InsertedBetweenPoints(
              dragginState.originLine!, dragginState.destination));
        }
      }
    });

    on<MovedPoint>((event, emit) {
      if (_isPointOnLine(event.newPosition)) {
        return;
      }

      final current = state.snapshots.last;
      final newSnapshot = current.copy();

      for (var i = 0; i < current.points.length; i++) {
        if (current.points[i] == event.point) {
          newSnapshot.points[i] = event.newPosition;
          break;
        }
      }

      emit(state.copyWith(
        snapshots: [
          ...state.snapshots,
          newSnapshot,
        ],
        stopDragging: true,
        clearFowardSnapshots: true,
      ));
    });

    on<InsertedBetweenPoints>((event, emit) {
      if (_isPointOnLine(event.point)) {
        return;
      }

      final current = state.current!;

      final newSnapshot = current.copy();

      for (var i = 0; i < current.points.length; i++) {
        final currentPoint = current.points[i];
        final nextIndex = (i + 1) % current.points.length;
        final nextPoint = current.points[nextIndex];

        if (event.line[0] == currentPoint && event.line[1] == nextPoint) {
          newSnapshot.points.insert(nextIndex, event.point);
          break;
        }
      }

      emit(state.copyWith(
        snapshots: [
          ...state.snapshots,
          newSnapshot,
        ],
        clearFowardSnapshots: true,
      ));
    });
  }

  /// Creates a new snapshot of the editor state with the given point added.
  Editor _createSnapshot(LatLng point) {
    final current = state.snapshots.isNotEmpty ? state.snapshots.last : null;
    if (current == null) {
      return Editor([point]);
    }

    return Editor([...current.points, point]);
  }

  /// Checks if the given point is on a line segment.
  bool _isPointOnLine(LatLng point) {
    final points = state.current?.points ?? [];

    for (var i = 0; i < points.length - 1; i++) {
      final pointA = points[i];
      final pointB = points[i + 1];

      if (isPointOnLine(pointA, pointB, point, strokeWidth: lineStrokeWidth)) {
        return true;
      }
    }
    return false;
  }
}
