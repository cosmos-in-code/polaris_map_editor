import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polaris_map_editor/options/area_options.dart';
import 'package:polaris_map_editor/options/line_options.dart';
import 'package:polaris_map_editor/options/menu_options.dart';
import 'package:polaris_map_editor/options/mouse_options.dart';
import 'package:polaris_map_editor/options/place_options.dart';
import 'package:polaris_map_editor/options/point_options.dart';
import 'package:polaris_map_editor/options/shortcut_options.dart';

/// Class that defines the overall customization options for the `PolarisMapEditor`.
class PolarisOptions {
  final bool readingMode;

  /// Customization options for areas.
  final AreaOptions area;

  /// Customization options for lines.
  final LineOptions line;

  /// Customization options for dragged lines.
  final LineOptions draggedLine;

  /// Customization options for points.
  final PointOptions point;

  /// Customization options for place search (optional).
  final PlaceOptions? place;

  /// Customization options for mouse interaction.
  final MouseOptions mouse;

  /// Customization options for keyboard shortcuts.
  final ShortcutOptions shortcut;

  /// Customization options for the context menu.
  final MenuOptions menu;

  /// Indicates whether place search is enabled (place != null).
  bool get isEnabledPlace => place != null;

  /// Default constructor.
  const PolarisOptions({
    this.readingMode = false,
    required this.area,
    required this.line,
    required this.draggedLine,
    required this.point,
    required this.place,
    required this.shortcut,
    required this.menu,
    this.mouse = const MouseOptions(),
  });

  /// Factory that creates a `PolarisOptions` object with default options.
  factory PolarisOptions.defaultOptions({
    bool readingMode = false,
    Color color = Colors.blue,
    String? googlePlaceApiKey,
  }) {
    return PolarisOptions(
      readingMode: readingMode,
      menu: const MenuOptions(
        enabled: true,
      ),
      area: AreaOptions(
        color: color.withOpacity(0.3),
        isFilled: true,
      ),
      line: LineOptions(
        color: color,
        strokeWidth: 3,
      ),
      draggedLine: LineOptions(
        color: color,
        strokeWidth: 3,
        isDotted: true,
      ),
      point: PointOptions(
        icon: Icon(
          Icons.circle,
          color: color,
          size: 14,
        ),
        lastPointIcon: Stack(
          fit: StackFit.expand,
          children: [
            Icon(
              Icons.circle,
              color: color,
              size: 10,
            ),
            Icon(
              Icons.circle_outlined,
              color: color,
              size: 19,
            ),
          ],
        ),
      ),
      place: googlePlaceApiKey != null
          ? PlaceOptions.googleMapService(apiKey: googlePlaceApiKey)
          : null,
      mouse: const MouseOptions(),
      shortcut: ShortcutOptions(
        undo: !readingMode
            ? [
                [LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyZ],
                [LogicalKeyboardKey.metaLeft, LogicalKeyboardKey.keyZ],
              ]
            : [],
        redo: !readingMode
            ? [
                [LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyY],
                [LogicalKeyboardKey.metaLeft, LogicalKeyboardKey.keyY],
                [
                  LogicalKeyboardKey.controlLeft,
                  LogicalKeyboardKey.shiftLeft,
                  LogicalKeyboardKey.keyZ
                ],
                [
                  LogicalKeyboardKey.metaLeft,
                  LogicalKeyboardKey.shiftLeft,
                  LogicalKeyboardKey.keyZ
                ],
              ]
            : [],
        search: googlePlaceApiKey != null
            ? [
                [LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyF],
                [LogicalKeyboardKey.metaLeft, LogicalKeyboardKey.keyF],
              ]
            : [],
        zoomIn: [
          [LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.add],
          [LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.equal],
          [LogicalKeyboardKey.metaLeft, LogicalKeyboardKey.add],
          [LogicalKeyboardKey.metaLeft, LogicalKeyboardKey.equal],
          [
            LogicalKeyboardKey.controlLeft,
            LogicalKeyboardKey.shiftLeft,
            LogicalKeyboardKey.add
          ],
          [
            LogicalKeyboardKey.metaLeft,
            LogicalKeyboardKey.shiftLeft,
            LogicalKeyboardKey.add
          ],
        ],
        zoomOut: [
          [LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.minus],
          [LogicalKeyboardKey.metaLeft, LogicalKeyboardKey.minus],
        ],
        fitCameraToArea: [
          [LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyH],
          [LogicalKeyboardKey.metaLeft, LogicalKeyboardKey.keyH],
        ],
        deletePoint: !readingMode
            ? [
                [LogicalKeyboardKey.controlLeft],
              ]
            : [],
      ),
    );
  }

  PolarisOptions copyWith({
    MenuOptions? menu,
    AreaOptions? area,
    LineOptions? line,
    LineOptions? draggedLine,
    PointOptions? point,
    PlaceOptions? place,
    MouseOptions? mouse,
    ShortcutOptions? shortcut,
  }) {
    return PolarisOptions(
      menu: menu ?? this.menu,
      area: area ?? this.area,
      line: line ?? this.line,
      draggedLine: draggedLine ?? this.draggedLine,
      point: point ?? this.point,
      place: place ?? this.place,
      mouse: mouse ?? this.mouse,
      shortcut: shortcut ?? this.shortcut,
    );
  }
}
