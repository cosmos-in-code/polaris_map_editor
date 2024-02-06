import 'package:flutter/services.dart';

/// Class that defines customization options for mouse interaction in the `PolarisMapEditor`.
class MouseOptions {
  /// The cursor shown when dragging an area or point.
  final MouseCursor dragCursor;

  /// The cursor shown when hovering over a point that can be deleted.
  final MouseCursor deletePointCursor;

  /// The default cursor shown when interacting with the map.
  final MouseCursor normalCursor;

  /// Default constructor for `MouseOptions`.
  const MouseOptions({
    this.dragCursor = SystemMouseCursors.grabbing,
    this.deletePointCursor = SystemMouseCursors.disappearing,
    this.normalCursor = SystemMouseCursors.basic,
  });
}
