import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polaris_map_editor/bloc/editor/editor_bloc.dart';

class RedoButton extends StatelessWidget {
  final Widget child;

  const RedoButton({
    super.key,
    this.child = const Icon(Icons.redo),
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditorBloc, EditorState>(
      builder: (context, state) => IconButton(
        onPressed: state.fowardSnapshots.isEmpty
            ? null
            : () => context.read<EditorBloc>().add(Redid()),
        icon: child,
      ),
    );
  }
}
