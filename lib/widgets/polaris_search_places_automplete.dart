import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polaris_map_editor/bloc/map/map_bloc.dart';
import 'package:polaris_map_editor/bloc/place/place_bloc.dart';
import 'package:polaris_map_editor/options/polaris_options.dart';

/// Widget responsible for displaying the Polaris search places autocomplete functionality.
class PolarisSearchPlacesAutocomplete extends StatefulWidget {
  /// Configuration options for the search places autocomplete.
  final PolarisOptions options;

  /// Creates a [PolarisSearchPlacesAutocomplete] with the specified options.
  const PolarisSearchPlacesAutocomplete({
    super.key,
    required this.options,
  });

  @override
  State<PolarisSearchPlacesAutocomplete> createState() =>
      _PolarisSearchPlacesAutocompleteState();
}

class _PolarisSearchPlacesAutocompleteState
    extends State<PolarisSearchPlacesAutocomplete> {
  /// Text editing controller for the search input field.
  final TextEditingController _controller = TextEditingController();

  /// Focus node for managing focus state of the search input field.
  final FocusNode _focus = FocusNode();

  /// Overlay entry used to display the search results popup.
  OverlayEntry? _overlayEntry;

  /// Layer link used for positioning the search results popup relative to the input field.
  final _layerLink = LayerLink();

  /// Reference to the PlaceBloc instance for managing place search logic.
  late final PlaceBloc _placeBloc;

  /// Reference to the MapBloc instance for handling map interactions.
  late final MapBloc _mapBloc;

  /// Scroll controller for the search results list.
  final _scrollController = ScrollController();

  /// The horizontal and vertical padding around the search popup.
  final _distanceBorders = 32.0;

  /// Flag to track the previous focus state of the input field.
  bool _lastFocusValue = false;

  @override
  void initState() {
    super.initState();

    // Access the PlaceBloc and MapBloc instances from the context.
    _placeBloc = context.read<PlaceBloc>();
    _mapBloc = context.read<MapBloc>();

    // Add a listener to the focus node to show the popup when focus is gained and the query length is at least 3.
    _focus.addListener(() {
      final hasGainedFocus = _focus.hasFocus && !_lastFocusValue;
      if (hasGainedFocus && _controller.text.length >= 3) {
        _showPopup();
      }
      _lastFocusValue = _focus.hasFocus;
    });
  }

  @override
  void dispose() {
    _placeBloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _placeBloc,
        ),
        BlocProvider.value(
          value: _mapBloc,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<PlaceBloc, PlaceState>(
            listenWhen: (previous, current) =>
                !previous.isShow && current.isShow,
            listener: (context, state) {
              _focus.requestFocus();
            },
          ),
          BlocListener<PlaceBloc, PlaceState>(
            listenWhen: (previous, current) =>
                previous.isShow && !current.isShow,
            listener: (context, state) {
              _removeOverlay();
            },
          ),
        ],
        child: BlocBuilder<PlaceBloc, PlaceState>(
          builder: (context, state) {
            return Visibility(
              visible: state.isShow,
              child: Positioned(
                top: _distanceBorders,
                left: _distanceBorders,
                right: _distanceBorders,
                child: CompositedTransformTarget(
                  link: _layerLink,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _controller,
                        focusNode: _focus,
                        onChanged: (value) {
                          EasyDebounce.debounce(
                              "search_autocomplete", Durations.short2, () {
                            if (_overlayEntry == null && value.length >= 3) {
                              _showPopup();
                            } else if (_overlayEntry != null &&
                                value.length < 3) {
                              _removeOverlay();
                            }

                            if (value.length >= 3) {
                              _placeBloc.add(RequestedFindPlace(value));
                            }
                          });
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: IconButton(
                            onPressed: () {
                              _controller.clear();
                              _removeOverlay();
                              _placeBloc.add(ToggledSearchPlacesVisibility());
                            },
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showPopup() {
    final height = MediaQuery.of(context).size.height * 0.5;
    _overlayEntry = OverlayEntry(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: _mapBloc,
          ),
          BlocProvider.value(
            value: _placeBloc,
          ),
        ],
        child: TapRegion(
          onTapOutside: (event) {
            Future.delayed(Durations.short1, () {
              if (!_focus.hasFocus) {
                _removeOverlay();
              }
            });
          },
          child: CompositedTransformFollower(
            link: _layerLink,
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: Alignment.topLeft,
            child: Material(
              color: Colors.transparent,
              child: Container(
                child: Stack(
                  children: [
                    Card(
                      child: SizedBox(
                        width: _layerLink.leaderSize!.width - 8,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: height,
                          ),
                          child: _List(
                            controller: _scrollController,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }
}

class _List extends StatelessWidget {
  final ScrollController controller;

  const _List({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceBloc, PlaceState>(
      builder: (context, state) {
        if (state.queryString.isEmpty || state.queryString.length < 3) {
          return const SizedBox.shrink();
        }

        if (state.status.isLoading) {
          return const SizedBox(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state.status.isCompleted && state.places.isEmpty) {
          return const SizedBox(
            height: 100,
            child: Center(
              child: Icon(Icons.playlist_add_check),
            ),
          );
        }

        if (state.status.isError) {
          return Center(
            child: Column(
              children: [
                const Icon(
                  Icons.cloud_off,
                  size: 40,
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<PlaceBloc>().add(RetriedFindPlace());
                  },
                  child: const Icon(Icons.refresh),
                ),
              ],
            ),
          );
        }

        return Scrollbar(
          controller: controller,
          thumbVisibility: true,
          child: ListView.separated(
            controller: controller,
            itemCount: state.places.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final place = state.places[index];
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: ListTile(
                  onTap: () {
                    context
                        .read<PlaceBloc>()
                        .add(RequestedHideSearchPlacesField());
                    context
                        .read<MapBloc>()
                        .add(ChangedPosition(place.location));
                  },
                  leading: place.iconImage != null
                      ? Image.network(
                          place.iconImage!,
                          width: 32,
                        )
                      : const Icon(
                          Icons.location_on,
                          size: 32,
                        ),
                  title: Text(place.name),
                  subtitle: Text(place.address),
                ),
              );
            },
            separatorBuilder: (_, __) => const Divider(
              height: 0.25,
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
