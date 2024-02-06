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
