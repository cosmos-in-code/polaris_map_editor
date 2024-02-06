import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:polaris_map_editor/bloc/editor/editor_bloc.dart';
import 'package:polaris_map_editor/options/polaris_options.dart';

class AreaLayer extends StatelessWidget {
  final PolarisOptions options;

  const AreaLayer({
    super.key,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditorBloc, EditorState>(
      builder: (context, state) => PolygonLayer(
        polygons: [
          if (state.snapshots.length > 2)
            Polygon(
              points: state.current!.points,
              color: options.area.color,
              isFilled: options.area.isFilled,
            ),
        ],
      ),
    );
  }
}
