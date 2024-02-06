import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polaris_map_editor/bloc/map/map_bloc.dart';

/// Button for performing "zoom in" action in the editor.
class ZoomInButton extends StatelessWidget {
  /// The icon or widget to display within the button.
  final Widget child;

  /// Creates a ZoomInButton with the specified child.
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
