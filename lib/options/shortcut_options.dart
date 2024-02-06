import 'package:flutter/services.dart';

/// Class that defines keyboard shortcut options for various actions in the `PolarisMapEditor`.
class ShortcutOptions {
  /// Key combinations for the "undo" action.
  final List<List<LogicalKeyboardKey>> undo;

  /// Key combinations for the "redo" action.
  final List<List<LogicalKeyboardKey>> redo;

  /// Key combinations for the "search" action.
  final List<List<LogicalKeyboardKey>> search;

  /// Key combinations for the "zoom in" action.
  final List<List<LogicalKeyboardKey>> zoomIn;

  /// Key combinations for the "zoom out" action.
  final List<List<LogicalKeyboardKey>> zoomOut;

  /// Key combinations for the "fit camera to area" action.
  final List<List<LogicalKeyboardKey>> fitCameraToArea;

  /// Key combinations for the "delete point" action (optional).
  final List<List<LogicalKeyboardKey>>? deletePoint;

  /// Default constructor for `ShortcutOptions`.
  const ShortcutOptions({
    required this.undo,
    required this.redo,
    required this.search,
    required this.zoomIn,
    required this.zoomOut,
    required this.fitCameraToArea,
    this.deletePoint,
  });

  /// Creates a copy of this `ShortcutOptions` object with optional overrides.
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
