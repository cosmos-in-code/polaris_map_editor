import 'dart:io';

import 'package:example/config.dart';
import 'package:flutter/material.dart';
import 'package:polaris_map_editor/polaris_map_editor.dart';
import 'package:polaris_map_editor/polaris_map_editor_dependencies.dart';

void main() {
  runApp(const Example());
}

/// An example of how to use the PolarisMapEditor widget.
class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Polaris Map Editor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Editor(),
    );
  }
}

class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  /// A flutter map controller used to control the map.
  final mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Polaris Map Editor'),
      ),
      body: PolarisMapEditor(
        mapController: mapController,
        options: PolarisOptions.defaultOptions(
          color: Colors.deepPurple,
          googlePlaceApiKey: Platform.isMacOS || Platform.isIOS
              ? Config.googlePlaceIosKey
              : Config.googlePlaceAndroidKey,
        ),
        onAreaChanged: print,
        child: FlutterMap(
          mapController: mapController,
          options: MapOptions(
            interactionOptions: InteractionOptions(
              cursorKeyboardRotationOptions:
                  CursorKeyboardRotationOptions.disabled(), // prevent shortcuts
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.cosmos-in-code.polaris_map_editor',
            ),
            const PolarisLayer(), // <===== Polaris widget
          ],
        ),
      ),
    );
  }
}
