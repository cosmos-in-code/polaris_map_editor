import 'package:latlong2/latlong.dart';

class Editor {
  final List<LatLng> points;

  Editor(this.points);

  Editor copy() => Editor([...points]);

  List<List<LatLng>> get lines {
    List<List<LatLng>> lines = [];

    for (var i = 0; i < points.length; i++) {
      final next = (i + 1) % points.length;
      lines.add([points[i], points[next]]);
    }

    return lines;
  }
}
