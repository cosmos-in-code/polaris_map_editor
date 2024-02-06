import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart' as flutter_map;
import 'package:flutter_map/flutter_map.dart';
import 'package:polaris_map_editor/bloc/editor/editor_bloc.dart';
import 'package:polaris_map_editor/bloc/map/map_bloc.dart';
import 'package:polaris_map_editor/bloc/place/place_bloc.dart';
import 'package:polaris_map_editor/models/polaris_options.dart';

class PolarisMapEditor extends StatefulWidget {
  final MapController mapController;
  final PolarisOptions options;
  final Widget child;

  PolarisMapEditor({
    super.key,
    required this.mapController,
    PolarisOptions? options,
    required this.child,
  }) : options = PolarisOptions.defaultOptions();

  @override
  State<PolarisMapEditor> createState() => _PolarisMapEditorState();
}

class _PolarisMapEditorState extends State<PolarisMapEditor> {
  late final StreamSubscription<flutter_map.MapEvent> _subscriptionMapEvent;
  final _editorBloc = EditorBloc();

  @override
  void initState() {
    super.initState();

    _subscriptionMapEvent = widget.mapController.mapEventStream.listen((event) {
      if (event is MapEventTap) {
        _editorBloc.add(AddedPoint(event.tapPosition));
      }
    });
  }

  @override
  void dispose() {
    _subscriptionMapEvent.cancel();
    _editorBloc.close();
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
        if (widget.options.isEnabledPlace)
          BlocProvider(
            create: (context) => PlaceBloc(
              repository: widget.options.place!.repository,
            ),
          ),
      ],
      child: BlocBuilder<EditorBloc, EditorState>(
        builder: (context, state) => MouseRegion(
          cursor: state.isDragging
              ? widget.options.mouse.dragCursor
              : widget.options.mouse.normalCursor,
          child: widget.child,
        ),
      ),
    );
  }
}
