import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galactic_hotkeys/galactic_hotkeys.dart';
import 'package:polaris_map_editor/bloc/editor/editor_bloc.dart';
import 'package:polaris_map_editor/bloc/map/map_bloc.dart';
import 'package:polaris_map_editor/bloc/place/place_bloc.dart';
import 'package:polaris_map_editor/enums/shortcut.dart';
import 'package:polaris_map_editor/models/polaris_options.dart';

class KeyboardListenerWidget extends StatelessWidget {
  final PolarisOptions options;
  final Widget child;

  const KeyboardListenerWidget({
    super.key,
    required this.options,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GalacticHotkeys<Shortcut>(
      shortcuts: {
        Shortcut.undo: options.shortcut.undo,
        Shortcut.redo: options.shortcut.redo,
        Shortcut.search: options.shortcut.search,
        Shortcut.zoomIn: options.shortcut.zoomIn,
        Shortcut.zoomOut: options.shortcut.zoomOut,
        Shortcut.fitCameraToArea: options.shortcut.fitCameraToArea,
      },
      onShortcutPressed: (shortcut, pressedKeys) {
        switch (shortcut) {
          case Shortcut.undo:
            context.read<EditorBloc>().add(Undid());
            break;
          case Shortcut.redo:
            context.read<EditorBloc>().add(Redid());
            break;
          case Shortcut.search:
            context.read<PlaceBloc>().add(ToggledSearchPlacesVisibility());
            break;
          case Shortcut.zoomIn:
            context.read<MapBloc>().add(ZoomedIn());
            break;
          case Shortcut.zoomOut:
            context.read<MapBloc>().add(ZoomedOut());
            break;
          case Shortcut.fitCameraToArea:
            final area = context.read<EditorBloc>().state.current?.points ?? [];
            context.read<MapBloc>().add(RequestedFitCameraToArea(area));
            break;
        }
      },
      child: child,
    );
  }
}
