import 'package:latlong2/latlong.dart';

/// Calculates the distance in meters between two LatLng points.
int differenceInMeters(LatLng a, LatLng b) {
  return (const Distance().as(LengthUnit.Meter, a, b)).toInt();
}

/// Checks if a point lies on a line segment defined by two other points, considering a tolerance for line width.
bool isPointOnLine(LatLng pointA, LatLng pointB, LatLng pointToCheck,
    {double strokeWidth = 1.0}) {
  // Calculate distances between points.
  final distanceAToB = differenceInMeters(pointA, pointB);
  final distanceAToX = differenceInMeters(pointA, pointToCheck);
  final distanceBToX = differenceInMeters(pointB, pointToCheck);

  // Calculate total distance along line segment.
  final distance = distanceAToX + distanceBToX - distanceAToB;

  // Check if point is within the line width tolerance.
  return distance <= strokeWidth;
}

/// Compares two lists of dynamic elements for equality.
bool compareLists(List<dynamic> array1, List<dynamic> array2) {
  // Check if lists have the same length.
  if (array1.length != array2.length) {
    return false;
  }

  // Iterate through elements and compare each pair.
  for (int i = 0; i < array1.length; i++) {
    if (array1[i] != array2[i]) {
      return false;
    }
  }

  // If all elements are equal, return true.
  return true;
}
