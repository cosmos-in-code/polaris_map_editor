import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polaris_map_editor/bloc/editor/editor_bloc.dart';

/// Button for performing "redo" action in the editor.

class RedoButton extends StatelessWidget {
  /// The icon or widget to display within the button.
  final Widget child;

  /// Creates a RedoButton with the specified child.
  const RedoButton({
    super.key,
    this.child = const Icon(Icons.redo),
  });

  @override
  Widget build(BuildContext context) {
    // Listens to EditorBloc state changes and builds the button accordingly.
    return BlocBuilder<EditorBloc, EditorState>(
      builder: (context, state) => IconButton(
        // Disables button if there are no forward snapshots (nothing to redo).
        onPressed: state.fowardSnapshots.isEmpty
            ? null
            : () => context.read<EditorBloc>().add(Redid()),
        icon: child,
      ),
    );
  }
}
