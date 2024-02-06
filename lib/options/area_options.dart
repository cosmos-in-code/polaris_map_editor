import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// Class that defines customization options for areas in the `PolarisMapEditor`.
class AreaOptions {
  /// Optional list of lists of LatLng coordinates defining holes within the area.
  final List<List<LatLng>>? holePointsList;

  /// The main color of the area.
  final Color color;

  /// The width of the border around the area.
  final double borderStrokeWidth;

  /// The color of the border around the area.
  final Color borderColor;

  /// Whether to disable the border for holes within the area.
  final bool disableHolesBorder;

  /// Whether to draw the area as a dotted line.
  final bool isDotted;

  /// Whether to fill the area with color.
  final bool isFilled;

  /// The style of the ends of the area's lines.
  final StrokeCap strokeCap;

  /// The style of the corners where lines meet in the area.
  final StrokeJoin strokeJoin;

  /// An optional label to display within the area.
  final String? label;

  /// The text style for the label.
  final TextStyle labelStyle;

  /// How to position the label within the area.
  final PolygonLabelPlacement labelPlacement;

  /// Whether to rotate the label to align with the area's shape.
  final bool rotateLabel;

  /// Default constructor for `AreaOptions`.
  const AreaOptions({
    this.holePointsList,
    required this.color,
    this.borderStrokeWidth = 0.0,
    this.borderColor = Colors.transparent,
    this.disableHolesBorder = false,
    this.isDotted = false,
    this.isFilled = false,
    this.strokeCap = StrokeCap.round,
    this.strokeJoin = StrokeJoin.round,
    this.label,
    this.labelStyle = const TextStyle(),
    this.labelPlacement = PolygonLabelPlacement.centroid,
    this.rotateLabel = false,
  });

  /// Creates a copy of this object with the given fields replaced with new values.
  AreaOptions copyWith({
    List<List<LatLng>>? holePointsList,
    Color? color,
    double? borderStrokeWidth,
    Color? borderColor,
    bool? disableHolesBorder,
    bool? isDotted,
    bool? isFilled,
    StrokeCap? strokeCap,
    StrokeJoin? strokeJoin,
    String? label,
    TextStyle? labelStyle,
    PolygonLabelPlacement? labelPlacement,
    bool? rotateLabel,
  }) {
    return AreaOptions(
      holePointsList: holePointsList ?? this.holePointsList,
      color: color ?? this.color,
      borderStrokeWidth: borderStrokeWidth ?? this.borderStrokeWidth,
      borderColor: borderColor ?? this.borderColor,
      disableHolesBorder: disableHolesBorder ?? this.disableHolesBorder,
      isDotted: isDotted ?? this.isDotted,
      isFilled: isFilled ?? this.isFilled,
      strokeCap: strokeCap ?? this.strokeCap,
      strokeJoin: strokeJoin ?? this.strokeJoin,
      label: label ?? this.label,
      labelStyle: labelStyle ?? this.labelStyle,
      labelPlacement: labelPlacement ?? this.labelPlacement,
      rotateLabel: rotateLabel ?? this.rotateLabel,
    );
  }
}
