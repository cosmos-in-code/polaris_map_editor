import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:polaris_map_editor/bloc/editor/editor_bloc.dart';
import 'package:polaris_map_editor/options/polaris_options.dart';

/// Widget displaying the drawn area on the map based on the current PolarisEditor state.
class AreaLayer extends StatelessWidget {
  /// Configuration options for the area's appearance.
  final PolarisOptions options;

  /// Creates an AreaLayer with the specified options.
  const AreaLayer({
    super.key,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    // Builds the widget based on the current EditorBloc state.
    return BlocBuilder<EditorBloc, EditorState>(
      builder: (context, state) => PolygonLayer(
        // Renders a polygon layer representing the drawn area.
        polygons: [
          // Only show the polygon if there are at least 3 points to define an area.
          if (state.snapshots.length > 2)
            Polygon(
              // Defines the polygon points based on the current editor state.
              points: state.current!.points,
              // Applies the configured color for the area.
              color: options.area.color,
              // Determines whether the area should be filled based on the options.
              isFilled: options.area.isFilled,
            ),
        ],
      ),
    );
  }
}
