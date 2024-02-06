import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polaris_map_editor/bloc/place/place_bloc.dart';

/// Button for performing "search place" action in the editor.
class SearchPlaceButton extends StatelessWidget {
  /// The icon or widget to display within the button.
  final Widget child;

  /// Creates a SearchPlaceButton with the specified child.
  const SearchPlaceButton({
    super.key,
    this.child = const Icon(Icons.search),
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<PlaceBloc>().add(ToggledSearchPlacesVisibility());
      },
      icon: child,
    );
  }
}
