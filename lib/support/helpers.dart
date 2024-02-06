import 'package:latlong2/latlong.dart';

int differenceInMeters(LatLng a, LatLng b) {
  return (const Distance().as(LengthUnit.Meter, a, b)).toInt();
}

bool isPointOnLine(LatLng pointA, LatLng pointB, LatLng pointToCheck,
    {double strokeWidth = 1.0}) {
  final distanceAToB = differenceInMeters(pointA, pointB);
  final distanceAToX = differenceInMeters(pointA, pointToCheck);
  final distanceBToX = differenceInMeters(pointB, pointToCheck);
  final distance = distanceAToX + distanceBToX - distanceAToB;
  return distance <= strokeWidth;
}

bool compareLists(List<dynamic> array1, List<dynamic> array2) {
  if (array1.length != array2.length) {
    return false;
  }

  for (int i = 0; i < array1.length; i++) {
    if (array1[i] != array2[i]) {
      return false;
    }
  }

  return true;
}
