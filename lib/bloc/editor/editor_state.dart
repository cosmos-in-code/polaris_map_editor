part of 'editor_bloc.dart';

/// Represents a state of the editor with a set of points.
class Editor {
  /// The list of geographic coordinates (LatLng) defining the points.
  final List<LatLng> points;
  final int version;

  /// Creates an Editor instance with the given points.
  Editor(this.points, {this.version = 0});

  /// Creates a copy of the Editor instance.
  Editor copyAndIncrementVersion() => Editor([...points], version: version + 1);

  /// Converts the points into a list of line segments connecting them.
  List<List<LatLng>> get lines {
    List<List<LatLng>> lines = [];

    for (var i = 0; i < points.length; i++) {
      final next = (i + 1) % points.length;
      lines.add([points[i], points[next]]);
    }

    return lines;
  }
}

/// Represents the overall state of the editor, including snapshots, forward snapshots, and dragging state.
class EditorState {
  /// List of past editor states (snapshots).
  final List<Editor> snapshots;

  /// List of undoable editor states after a redo action.
  final List<Editor> fowardSnapshots;

  /// Information about the currently dragged point (if any).
  final Drag? dragging;

  /// Indicates if a point is currently being dragged.
  bool get isDragging => dragging != null;

  /// Creates an EditorState instance with the specified snapshots, forward snapshots, and dragging state.
  const EditorState({
    this.snapshots = const [],
    this.fowardSnapshots = const [],
    this.dragging,
  });

  /// Creates a copy of the EditorState with optional modifications.
  EditorState copyWith({
    List<Editor>? snapshots,
    List<Editor>? fowardSnapshots,
    bool clearFowardSnapshots = false,
    Drag? dragging,
    bool stopDragging = false,
  }) {
    return EditorState(
      snapshots: snapshots ?? this.snapshots,
      fowardSnapshots:
          clearFowardSnapshots ? [] : (fowardSnapshots ?? this.fowardSnapshots),
      dragging: stopDragging ? null : (dragging ?? this.dragging),
    );
  }

  /// Returns a list of points involved in the dragging operation, including neighbors if applicable.
  List<LatLng> get draggedPointWithNeighbors {
    if (dragging == null) {
      return [];
    }

    final result = <LatLng>[];

    if (dragging!.type == DragType.fromLine) {
      // Include origin, destination, and other endpoint of the line
      result.add(dragging!.originLine![0]);
      result.add(dragging!.destination);
      result.add(dragging!.originLine![1]);
    } else if (dragging!.type == DragType.fromPoint) {
      // Include dragged point, neighbors based on current points
      final points = (current?.points ?? []);

      if (points.length <= 1) {
        return points;
      }

      for (var i = 0; i < points.length; i++) {
        var prevIndex = i == 0 ? points.length - 1 : (i - 1) % points.length;
        final nextIndex = (i + 1) % points.length;

        if (points[i] == dragging!.originPoint) {
          if (points.length > 2) {
            result.add(points[prevIndex]);
          }
          result.add(dragging!.destination);
          result.add(points[nextIndex]);
          break;
        }
      }
    }
    return result;
  }

  /// Returns the current editor state (last snapshot if any).
  Editor? get current => snapshots.isNotEmpty ? snapshots.last : null;
}
