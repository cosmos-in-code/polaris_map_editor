import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galactic_hotkeys/galactic_hotkeys.dart';
import 'package:polaris_map_editor/bloc/editor/editor_bloc.dart';
import 'package:polaris_map_editor/bloc/map/map_bloc.dart';
import 'package:polaris_map_editor/bloc/place/place_bloc.dart';
import 'package:polaris_map_editor/enums/shortcut.dart';
import 'package:polaris_map_editor/options/polaris_options.dart';

class PolarisKeyboardListener extends StatefulWidget {
  final PolarisOptions options;
  final Widget child;

  const PolarisKeyboardListener({
    super.key,
    required this.options,
    required this.child,
  });

  @override
  State<PolarisKeyboardListener> createState() =>
      _PolarisKeyboardListenerState();
}

class _PolarisKeyboardListenerState extends State<PolarisKeyboardListener> {
  final _focusScopeNode = FocusScopeNode();

  @override
  void dispose() {
    _focusScopeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlaceBloc, PlaceState>(
      listenWhen: (previous, current) => previous.isShow && !current.isShow,
      listener: (context, state) {
        _focusScopeNode.requestFocus();
      },
      child: GalacticHotkeys<Shortcut>(
        focusScopeNode: _focusScopeNode,
        shortcuts: {
          Shortcut.undo: widget.options.shortcut.undo,
          Shortcut.redo: widget.options.shortcut.redo,
          Shortcut.search: widget.options.shortcut.search,
          Shortcut.zoomIn: widget.options.shortcut.zoomIn,
          Shortcut.zoomOut: widget.options.shortcut.zoomOut,
          Shortcut.fitCameraToArea: widget.options.shortcut.fitCameraToArea,
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
              final area =
                  context.read<EditorBloc>().state.current?.points ?? [];
              context.read<MapBloc>().add(RequestedFitCameraToArea(area));
              break;
          }
        },
        child: widget.child,
      ),
    );
  }
}
