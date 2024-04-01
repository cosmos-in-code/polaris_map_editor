import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polaris_map_editor/bloc/editor/editor_bloc.dart';

/// Button for performing "undo" action in the editor.
class UndoButton extends StatelessWidget {
  /// The icon or widget to display within the button.
  final Widget child;

  /// Creates a UndoButton with the specified child.
  const UndoButton({
    super.key,
    this.child = const Icon(Icons.undo),
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditorBloc, EditorState>(
      builder: (context, state) => IconButton(
        onPressed: state.snapshots.length > 1
            ? () => context.read<EditorBloc>().add(Undid())
            : null,
        icon: child,
      ),
    );
  }
}
