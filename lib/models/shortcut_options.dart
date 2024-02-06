import 'package:flutter/services.dart';

class ShortcutOptions {
  final List<List<LogicalKeyboardKey>> undo;
  final List<List<LogicalKeyboardKey>> redo;
  final List<List<LogicalKeyboardKey>> search;
  final List<List<LogicalKeyboardKey>> zoomIn;
  final List<List<LogicalKeyboardKey>> zoomOut;
  final List<List<LogicalKeyboardKey>> fitCameraToArea;
  final List<List<LogicalKeyboardKey>>? deletePoint;

  const ShortcutOptions({
    required this.undo,
    required this.redo,
    required this.search,
    required this.zoomIn,
    required this.zoomOut,
    required this.fitCameraToArea,
    this.deletePoint,
  });

  ShortcutOptions copyWith({
    List<List<LogicalKeyboardKey>>? undo,
    List<List<LogicalKeyboardKey>>? redo,
    List<List<LogicalKeyboardKey>>? search,
    List<List<LogicalKeyboardKey>>? zoomIn,
    List<List<LogicalKeyboardKey>>? zoomOut,
    List<List<LogicalKeyboardKey>>? fitCameraToArea,
    List<List<LogicalKeyboardKey>>? deletePoint,
  }) {
    return ShortcutOptions(
      undo: undo ?? this.undo,
      redo: redo ?? this.redo,
      search: search ?? this.search,
      zoomIn: zoomIn ?? this.zoomIn,
      zoomOut: zoomOut ?? this.zoomOut,
      fitCameraToArea: fitCameraToArea ?? this.fitCameraToArea,
      deletePoint: deletePoint ?? this.deletePoint,
    );
  }
}
