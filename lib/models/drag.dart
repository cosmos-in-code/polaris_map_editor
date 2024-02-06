import 'package:latlong2/latlong.dart';
import 'package:polaris_map_editor/enums/drag_type.dart';

/// Represents a drag operation within a map editor.
class Drag {
  /// The type of drag operation (either dragging a point or a line).
  final DragType type;

  /// The original point being dragged, if applicable.
  final LatLng? originPoint;

  /// The original line being dragged, if applicable.
  final List<LatLng>? originLine;

  /// The current destination point of the drag operation.
  final LatLng destination;

  /// Creates a Drag instance for dragging a point.
  factory Drag.fromPoint(LatLng originPoint, LatLng destination) {
    return Drag._(
      type: DragType.fromPoint,
      originPoint: originPoint,
      destination: destination,
      originLine: null,
    );
  }

  /// Creates a Drag instance for dragging a line.
  factory Drag.fromLine(List<LatLng> originLine, LatLng destination) {
    return Drag._(
      type: DragType.fromLine,
      originLine: originLine,
      destination: destination,
      originPoint: null,
    );
  }

  /// Private constructor to ensure creation through factory methods.
  Drag._({
    this.originLine,
    this.originPoint,
    required this.destination,
    required this.type,
  });

  /// Creates a copy of this Drag instance with optional modifications.
  Drag copyWith({
    DragType? type,
    LatLng? originPoint,
    List<LatLng>? originLine,
    LatLng? destination,
  }) {
    return Drag._(
      type: type ?? this.type,
      originPoint: originPoint ?? this.originPoint,
      originLine: originLine ?? this.originLine,
      destination: destination ?? this.destination,
    );
  }
}
