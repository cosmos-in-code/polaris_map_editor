import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:galactic_hotkeys/galactic_hotkeys.dart';
import 'package:polaris_map_editor/bloc/editor/editor_bloc.dart';
import 'package:polaris_map_editor/options/polaris_options.dart';

/// Widget responsible for displaying and managing point interactions on the map.
class PointsLayer extends StatelessWidget {
  /// Configuration options for the points' appearance and behavior.
  final PolarisOptions options;

  /// Creates a PointsLayer with the specified options.
  const PointsLayer({
    super.key,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditorBloc, EditorState>(
      builder: (context, editorState) {
        final points = editorState.current?.points ?? [];
        final markers = <Marker>[];

        for (var i = 0; i < points.length; i++) {
          final point = points[i];
          final isLast = i == points.length - 1;

          markers.add(
            Marker(
              point: point, // this is the position of the marker
              child: GalacticHotkeysBuilder(
                builder: (context, List<LogicalKeyboardKey> pressedKeys) {
                  final editorBloc = context.read<EditorBloc>();
                  final deleteIsPessed = options.shortcut.deletePoint!.every(
                    (shortcut) => shortcut.every(
                      (key) => pressedKeys.contains(key),
                    ),
                  );

                  late final MouseCursor cursor;

                  if (deleteIsPessed) {
                    cursor = options.mouse.deletePointCursor;
                  } else if (editorState.isDragging) {
                    cursor = options.mouse.dragCursor;
                  } else {
                    cursor = options.mouse.normalCursor;
                  }

                  late final Widget child;

                  if (options.point.custom) {
                    child = options.point.builder!(context, point, isLast);
                  } else if (isLast) {
                    child = options.point.lastPointIcon!;
                  } else {
                    child = options.point.icon!;
                  }

                  if (options.readingMode) {
                    return child;
                  }

                  return MouseRegion(
                    cursor: cursor,
                    child: GestureDetector(
                      onTap: () {
                        if (deleteIsPessed) {
                          editorBloc.add(DeletedPoint(point));
                        }
                      },
                      onLongPressStart: (details) {
                        editorBloc.add(DraggingPoint(point, point));
                      },
                      onLongPressMoveUpdate: (details) {
                        final map = MapCamera.of(context);
                        final pointOffset = map.getOffsetFromOrigin(point);
                        final newPosition = map.offsetToCrs(
                          pointOffset.translate(
                            details.offsetFromOrigin.dx,
                            details.offsetFromOrigin.dy,
                          ),
                        );
                        editorBloc.add(DraggingPoint(point, newPosition));
                      },
                      onLongPressUp: () {
                        editorBloc.add(DraggedPoint());
                      },
                      child: child,
                    ),
                  );
                },
              ),
            ),
          );
        }

        if (editorState.dragging != null) {
          markers.add(
            Marker(
              point: editorState.dragging!.destination,
              child: Builder(
                builder: (context) {
                  // final originIsLast = editorState.dragging!.origin ==
                  if (options.point.custom) {
                    return options.point.builder!(
                        context, editorState.dragging!.destination, false);
                  } else {
                    return options.point.icon!;
                  }
                },
              ),
            ),
          );
        }

        return MarkerLayer(
          markers: markers,
        );
      },
    );
  }
}
