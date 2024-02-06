import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polaris_map_editor/bloc/editor/editor_bloc.dart';
import 'package:polaris_map_editor/bloc/map/map_bloc.dart';

/// Button that triggers fitting the map camera to the drawn area.
class FitCameraToAreaButton extends StatelessWidget {
  /// The icon or widget to display within the button.
  final Widget child;

  /// Creates a FitCameraToAreaButton with the specified child.
  const FitCameraToAreaButton({
    super.key,
    this.child = const Icon(Icons.crop_free),
  });

  @override
  Widget build(BuildContext context) {
    // Listens to EditorBloc state changes and builds the button accordingly.
    return BlocBuilder<EditorBloc, EditorState>(
      builder: (context, state) {
        // Returns an IconButton that triggers the camera fit action if there are points.
        return IconButton(
          onPressed: state.current?.points.isNotEmpty == true
              ? () => context.read<MapBloc>().add(
                    RequestedFitCameraToArea(state.current!.points),
                  )
              : null,
          icon: child,
        );
      },
    );
  }
}
