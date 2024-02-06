import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polaris_map_editor/bloc/map/map_bloc.dart';

/// Button for performing "zoom out" action in the editor.
class ZoomOutButton extends StatelessWidget {
  /// The icon or widget to display within the button.
  final Widget child;

  /// Creates a ZoomOutButton with the specified child.
  const ZoomOutButton({
    super.key,
    this.child = const Icon(Icons.zoom_out),
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        final camera = state.mapController.camera;

        return IconButton(
          onPressed: camera.minZoom != null && camera.minZoom! >= camera.zoom
              ? null
              : () => context.read<MapBloc>().add(ZoomedOut()),
          icon: child,
        );
      },
    );
  }
}
