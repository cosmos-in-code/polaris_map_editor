import 'package:latlong2/latlong.dart';

/// Represents an editor for managing a list of LatLng points.
class Editor {
  /// The list of LatLng points being edited.
  final List<LatLng> points;

  /// Creates an Editor instance with the specified initial points.
  Editor(this.points);

  /// Creates a copy of this Editor instance with a new list of points.
  /// This avoids modifying the original data directly.
  Editor copy() => Editor([...points]);

  /// Gets a list of line segments formed by connecting consecutive points.
  /// Each line segment is represented as a list of two LatLng points.
  List<List<LatLng>> get lines {
    final lines = <List<LatLng>>[];

    // Iterate through each point and connect it to the next point in the list.
    for (var i = 0; i < points.length; i++) {
      // Calculate the index of the next point, wrapping around if necessary.
      final nextIndex = (i + 1) % points.length;
      // Add the current point and next point to a new line segment.
      lines.add([points[i], points[nextIndex]]);
    }

    return lines;
  }
}
