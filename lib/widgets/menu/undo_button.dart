import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polaris_map_editor/bloc/editor/editor_bloc.dart';

class UndoButton extends StatelessWidget {
  final Widget child;

  const UndoButton({
    super.key,
    this.child = const Icon(Icons.undo),
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditorBloc, EditorState>(
      builder: (context, state) => IconButton(
        onPressed: state.snapshots.isEmpty
            ? null
            : () => context.read<EditorBloc>().add(Undid()),
        icon: child,
      ),
    );
  }
}
