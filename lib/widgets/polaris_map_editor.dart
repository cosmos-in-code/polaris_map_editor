import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart' as flutter_map;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:polaris_map_editor/bloc/editor/editor_bloc.dart';
import 'package:polaris_map_editor/bloc/map/map_bloc.dart';
import 'package:polaris_map_editor/bloc/place/place_bloc.dart';
import 'package:polaris_map_editor/options/polaris_options.dart';
import 'package:polaris_map_editor/support/helpers.dart';
import 'package:polaris_map_editor/widgets/polaris_keyboard_listener.dart';
import 'package:polaris_map_editor/widgets/polaris_menu.dart';
import 'package:polaris_map_editor/widgets/polaris_search_places_automplete.dart';
import 'package:provider/provider.dart';

/// Widget responsible for displaying the Polaris map editor.
class PolarisMapEditor extends StatefulWidget {
  /// The flutter map controller used to control the map.
  final MapController mapController;

  /// Configuration options for the map editor.
  final PolarisOptions options;

  /// The initial area of the map editor.
  final List<LatLng> initialArea;

  /// The widget to display within the map editor.
  final Widget child;

  /// Called when the area changes.
  final Function(List<LatLng> area)? onAreaChanged;

  /// Creates a PolarisMapEditor with the specified options and child.
  PolarisMapEditor({
    super.key,
    required this.mapController,
    PolarisOptions? options,
    this.initialArea = const [],
    this.onAreaChanged,
    required this.child,
  }) : options = options ?? PolarisOptions.defaultOptions();

  @override
  State<PolarisMapEditor> createState() => _PolarisMapEditorState();
}

class _PolarisMapEditorState extends State<PolarisMapEditor> {
  late final EditorBloc _editorBloc;
  late final StreamSubscription<flutter_map.MapEvent>? _subscriptionMapEvent;
  late final StreamSubscription<EditorState>? _subscriptionEditorState;
  final _focusScopeNode = FocusScopeNode();
  var _currentArea = <LatLng>[];

  @override
  void initState() {
    super.initState();
    _editorBloc = EditorBloc(
      initialArea: widget.initialArea,
      lineStrokeWidth: widget.options.line.strokeWidth,
    );

    if (widget.options.readingMode) {
      _subscriptionMapEvent = null;
      _subscriptionEditorState = null;
      return;
    }

    if (widget.onAreaChanged != null) {
      _subscriptionEditorState = _editorBloc.stream.listen((event) {
        final points = event.current?.points ?? [];

        if (!compareLists(points, _currentArea)) {
          _currentArea = points;
          widget.onAreaChanged!(points);
        }
      });
    } else {
      _subscriptionEditorState = null;
    }

    _subscriptionMapEvent = widget.mapController.mapEventStream.listen((event) {
      if (event is MapEventTap) {
        _editorBloc.add(AddedPoint(event.tapPosition));
      }
    });
  }

  @override
  void dispose() {
    _subscriptionEditorState?.cancel();
    _subscriptionMapEvent?.cancel();
    _editorBloc.close();
    _focusScopeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _editorBloc,
        ),
        BlocProvider(
          create: (context) => MapBloc(
            mapController: widget.mapController,
          ),
        ),
        BlocProvider(
          create: (context) => PlaceBloc(
            repository: widget.options.place?.repository,
          ),
        ),
      ],
      child: BlocBuilder<PlaceBloc, PlaceState>(
        builder: (context, placeState) {
          return BlocBuilder<EditorBloc, EditorState>(
            builder: (context, editorState) => MouseRegion(
              cursor: editorState.isDragging
                  ? widget.options.mouse.dragCursor
                  : widget.options.mouse.normalCursor,
              child: Provider<PolarisOptions>.value(
                value: widget.options,
                child: Stack(
                  children: [
                    PolarisKeyboardListener(
                      options: widget.options,
                      child: widget.child,
                    ),
                    PolarisMenu(
                      options: widget.options,
                    ),
                    if (widget.options.isEnabledPlace)
                      PolarisSearchPlacesAutocomplete(
                        options: widget.options,
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
