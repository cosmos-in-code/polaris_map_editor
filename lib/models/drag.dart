import 'package:latlong2/latlong.dart';
import 'package:polaris_map_editor/enums/drag_type.dart';

class Drag {
  final DragType type;
  final LatLng? originPoint;
  final List<LatLng>? originLine;
  final LatLng destination;

  factory Drag.fromPoint(LatLng originPoint, LatLng destination) {
    return Drag._(
      type: DragType.fromPoint,
      originPoint: originPoint,
      destination: destination,
      originLine: null,
    );
  }

  factory Drag.fromLine(List<LatLng> originLine, LatLng destination) {
    return Drag._(
      type: DragType.fromLine,
      originLine: originLine,
      destination: destination,
      originPoint: null,
    );
  }

  Drag._({
    this.originLine,
    this.originPoint,
    required this.destination,
    required this.type,
  });

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
