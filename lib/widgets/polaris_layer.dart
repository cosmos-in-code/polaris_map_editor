import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polaris_map_editor/options/polaris_options.dart';
import 'package:polaris_map_editor/widgets/layers/area_layer.dart';
import 'package:polaris_map_editor/widgets/layers/lines_layer.dart';
import 'package:polaris_map_editor/widgets/layers/points_layer.dart';

/// Widget responsible for displaying the Polaris map editor layers. Includes AreaLayer, LinesLayer and PointsLayer.
class PolarisLayer extends StatelessWidget {
  /// Creates a PolarisLayer.
  const PolarisLayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final options = context.read<PolarisOptions>();
    return Stack(
      children: [
        AreaLayer(
          options: options,
        ),
        LinesLayer(
          options: options,
        ),
        PointsLayer(
          options: options,
        ),
      ],
    );
  }
}
