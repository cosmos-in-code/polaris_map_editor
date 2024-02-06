import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:galactic_hotkeys/galactic_hotkeys.dart';
import 'package:polaris_map_editor/bloc/editor/editor_bloc.dart';
import 'package:polaris_map_editor/models/polaris_options.dart';

class PointsLayer extends StatelessWidget {
  final PolarisOptions options;

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

                  return MouseRegion(
                    cursor: cursor,
                    child: GestureDetector(
                      dragStartBehavior: DragStartBehavior.down,
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
              child: const Icon(
                Icons.circle,
                color: Colors.blue,
                size: 14,
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
