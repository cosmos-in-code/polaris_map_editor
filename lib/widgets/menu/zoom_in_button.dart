import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polaris_map_editor/bloc/map/map_bloc.dart';

class ZoomInButton extends StatelessWidget {
  final Widget child;

  const ZoomInButton({
    super.key,
    this.child = const Icon(Icons.zoom_in),
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        final camera = state.mapController.camera;

        return IconButton(
          onPressed: camera.maxZoom != null && camera.maxZoom! <= camera.zoom
              ? null
              : () => context.read<MapBloc>().add(ZoomedIn()),
          icon: child,
        );
      },
    );
  }
}
