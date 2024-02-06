import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:polaris_map_editor/bloc/editor/editor_bloc.dart';
import 'package:polaris_map_editor/options/polaris_options.dart';
import 'package:polaris_map_editor/support/helpers.dart';

/// Widget responsible for displaying and managing line interactions on the map.
class LinesLayer extends StatelessWidget {
  /// Configuration options for the lines' appearance.
  final PolarisOptions options;

  /// Creates a LinesLayer with the specified options.
  const LinesLayer({
    super.key,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    // Accesses the map camera for coordinate conversions.
    final map = MapCamera.of(context);

    // Listens to EditorBloc state changes and builds the widget accordingly.
    return BlocBuilder<EditorBloc, EditorState>(
      builder: (context, state) {
        // Wraps the layer in a gesture detector to handle line interactions.
        return GestureDetector(
          // Initiates dragging immediately on touch down.
          dragStartBehavior: DragStartBehavior.down,

          // Handles long press start events:
          onLongPressStart: (details) {
            // Converts the tap position to map coordinates.
            final pointTap = map.offsetToCrs(details.localPosition);

            // Iterates through the current lines:
            for (var line in (state.current?.lines ?? [])) {
              final pointA = line[0];
              final pointB = line[1];

              // Checks if the tap is on the line:
              if (isPointOnLine(pointA, pointB, pointTap)) {
                // Notifies the EditorBloc about starting point dragging.
                final editorBloc = context.read<EditorBloc>();
                editorBloc.add(StartedDraggingPointFromLine(
                  [pointA, pointB],
                  pointTap,
                ));
                return; // Exits the loop as a line has been found.
              }
            }
          },

          // Handles long press move updates:
          onLongPressMoveUpdate: (details) {
            // Converts the tap position to map coordinates.
            final pointTap = map.offsetToCrs(details.localPosition);

            // Notifies the EditorBloc about dragging the point.
            context.read<EditorBloc>().add(DraggingPointFromLine(pointTap));
          },

          // Handles long press end and cancel events:
          onLongPressEnd: (details) {
            context.read<EditorBloc>().add(DraggedPoint());
          },
          onLongPressCancel: () {
            context.read<EditorBloc>().add(DraggedPoint());
          },

          // Displays the actual layer with lines:
          child: PolylineLayer(
            polylines: [
              // Renders the regular lines based on the current state:
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

              // Renders the dragged line if a point is being dragged:
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
