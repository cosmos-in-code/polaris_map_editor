import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polaris_map_editor/bloc/place/place_bloc.dart';

class SearchPlaceButton extends StatelessWidget {
  final Widget child;

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
