part of 'editor_bloc.dart';

class Editor {
  final List<LatLng> points;

  Editor(this.points);

  Editor copy() => Editor([...points]);

  List<List<LatLng>> get lines {
    List<List<LatLng>> lines = [];

    for (var i = 0; i < points.length; i++) {
      final next = (i + 1) % points.length;
      lines.add([points[i], points[next]]);
    }

    return lines;
  }
}

class EditorState {
  final List<Editor> snapshots;
  final List<Editor> fowardSnapshots;
  final Drag? dragging;

  bool get isDragging => dragging != null;

  const EditorState({
    this.snapshots = const [],
    this.fowardSnapshots = const [],
    this.dragging,
  });

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

  List<LatLng> get draggedPointWithNeighbors {
    if (dragging == null) {
      return [];
    }

    final result = <LatLng>[];

    if (dragging!.type == DragType.fromLine) {
      result.add(dragging!.originLine![0]);
      result.add(dragging!.destination);
      result.add(dragging!.originLine![1]);
    } else if (dragging!.type == DragType.fromPoint) {
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

  Editor? get current => snapshots.isNotEmpty ? snapshots.last : null;
}
