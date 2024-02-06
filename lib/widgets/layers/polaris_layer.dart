import 'package:flutter/material.dart';
import 'package:polaris_map_editor/models/polaris_options.dart';
import 'package:polaris_map_editor/widgets/layers/area_layer.dart';
import 'package:polaris_map_editor/widgets/layers/lines_layer.dart';
import 'package:polaris_map_editor/widgets/layers/points_layer.dart';

class PolarisLayer extends StatelessWidget {
  final PolarisOptions options;

  const PolarisLayer({
    super.key,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
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
