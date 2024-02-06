import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polaris_map_editor/models/area_options.dart';
import 'package:polaris_map_editor/models/line_options.dart';
import 'package:polaris_map_editor/models/mouse_options.dart';
import 'package:polaris_map_editor/models/place_options.dart';
import 'package:polaris_map_editor/models/point_options.dart';
import 'package:polaris_map_editor/models/shortcut_options.dart';

class PolarisOptions {
  final AreaOptions area;

  final LineOptions line;
  final LineOptions draggedLine;
  final PointOptions point;
  final PlaceOptions? place;
  final MouseOptions mouse;
  final ShortcutOptions shortcut;

  bool get isEnabledPlace => place != null;

  const PolarisOptions({
    required this.area,
    required this.line,
    required this.draggedLine,
    required this.point,
    required this.place,
    required this.shortcut,
    this.mouse = const MouseOptions(),
  });

  factory PolarisOptions.defaultOptions({
    Color color = Colors.blue,
    String? googlePlaceApiKey,
  }) {
    return PolarisOptions(
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
      shortcut: const ShortcutOptions(
        undo: [
          [LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyZ],
          [LogicalKeyboardKey.metaLeft, LogicalKeyboardKey.keyZ],
        ],
        redo: [
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
        ],
        search: [
          [LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyF],
          [LogicalKeyboardKey.metaLeft, LogicalKeyboardKey.keyF],
        ],
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
        deletePoint: [
          [LogicalKeyboardKey.controlLeft],
        ],
      ),
    );
  }

  PolarisOptions copyWith({
    AreaOptions? area,
    LineOptions? line,
    LineOptions? draggedLine,
    PointOptions? point,
    PlaceOptions? place,
    MouseOptions? mouse,
    ShortcutOptions? shortcut,
  }) {
    return PolarisOptions(
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
