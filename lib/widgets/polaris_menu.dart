import 'package:flutter/material.dart';
import 'package:polaris_map_editor/options/polaris_options.dart';
import 'package:polaris_map_editor/widgets/menu/divider_vertical.dart';
import 'package:polaris_map_editor/widgets/menu/fit_camera_to_area_button.dart';
import 'package:polaris_map_editor/widgets/menu/redo_button.dart';
import 'package:polaris_map_editor/widgets/menu/search_place_button.dart';
import 'package:polaris_map_editor/widgets/menu/undo_button.dart';
import 'package:polaris_map_editor/widgets/menu/zoom_in_button.dart';
import 'package:polaris_map_editor/widgets/menu/zoom_out_button.dart';

/// Widget responsible for displaying the Polaris map editor menu. Includes UndoButton, RedoButton, ZoomOutButton, ZoomInButton, FitCameraToAreaButton and (optional) SearchPlaceButton.
class PolarisMenu extends StatelessWidget {
  /// Configuration options for the map editor.
  final PolarisOptions options;

  /// Creates a PolarisMenu with the specified options.
  const PolarisMenu({
    super.key,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 32,
      left: 0,
      right: 0,
      child: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const UndoButton(),
                const RedoButton(),
                const DividerVertical(),
                const ZoomOutButton(),
                const ZoomInButton(),
                const FitCameraToAreaButton(),
                const DividerVertical(),
                if (options.isEnabledPlace) const SearchPlaceButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}