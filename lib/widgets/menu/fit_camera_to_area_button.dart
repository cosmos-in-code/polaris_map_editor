import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polaris_map_editor/bloc/editor/editor_bloc.dart';
import 'package:polaris_map_editor/bloc/map/map_bloc.dart';

class FitCameraToAreaButton extends StatelessWidget {
  final Widget child;

  const FitCameraToAreaButton({
    super.key,
    this.child = const Icon(Icons.crop_free),
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditorBloc, EditorState>(
      builder: (context, state) {
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
