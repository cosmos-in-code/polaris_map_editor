import 'package:flutter/material.dart';

class MouseOptions {
  final MouseCursor dragCursor;
  final MouseCursor deletePointCursor;
  final MouseCursor normalCursor;

  const MouseOptions({
    this.dragCursor = SystemMouseCursors.grabbing,
    this.deletePointCursor = SystemMouseCursors.disappearing,
    this.normalCursor = SystemMouseCursors.basic,
  });
}
