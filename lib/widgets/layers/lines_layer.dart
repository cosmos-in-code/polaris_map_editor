import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:polaris_map_editor/bloc/editor/editor_bloc.dart';
import 'package:polaris_map_editor/options/polaris_options.dart';
import 'package:polaris_map_editor/support/helpers.dart';

class LinesLayer extends StatelessWidget {
  final PolarisOptions options;

  const LinesLayer({
    super.key,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    final map = MapCamera.of(context);

    return BlocBuilder<EditorBloc, EditorState>(
      builder: (context, state) {
        return GestureDetector(
          dragStartBehavior: DragStartBehavior.down,
          onLongPressStart: (details) {
            final pointTap = map.offsetToCrs(details.localPosition);
            for (var line in (state.current?.lines ?? [])) {
              final pointA = line[0];
              final pointB = line[1];
              if (isPointOnLine(pointA, pointB, pointTap)) {
                final editorBloc = context.read<EditorBloc>();
                editorBloc.add(StartedDraggingPointFromLine(
                  [pointA, pointB],
                  pointTap,
                ));
                return;
              }
            }
          },
          onLongPressMoveUpdate: (details) {
            final pointTap = map.offsetToCrs(details.localPosition);
            context.read<EditorBloc>().add(DraggingPointFromLine(pointTap));
          },
          onLongPressEnd: (details) {
            context.read<EditorBloc>().add(DraggedPoint());
          },
          onLongPressCancel: () {
            context.read<EditorBloc>().add(DraggedPoint());
          },
          child: PolylineLayer(
            polylines: [
              for (var line in state.current?.lines ?? [])
                Polyline(
                  points: line,
                  color: options.line.color,
                  strokeWidth: options.line.strokeWidth,
                  isDotted: options.line.isDotted,
                  gradientColors: options.line.gradientColors,
                  colorsStop: options.line.colorsStop,
                  strokeCap: options.line.strokeCap,
                  strokeJoin: options.line.strokeJoin,
                  useStrokeWidthInMeter: options.line.useStrokeWidthInMeter,
                ),
              if (state.dragging != null)
                Polyline(
                  points: state.draggedPointWithNeighbors,
                  color: options.draggedLine.color,
                  strokeWidth: options.draggedLine.strokeWidth,
                  isDotted: options.draggedLine.isDotted,
                  gradientColors: options.draggedLine.gradientColors,
                  colorsStop: options.draggedLine.colorsStop,
                  strokeCap: options.draggedLine.strokeCap,
                  strokeJoin: options.draggedLine.strokeJoin,
                  useStrokeWidthInMeter:
                      options.draggedLine.useStrokeWidthInMeter,
                ),
            ],
          ),
        );
      },
    );
  }
}
