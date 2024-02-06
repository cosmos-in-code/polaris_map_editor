import 'package:flutter/material.dart';

/// Class that defines customization options for lines in the `PolarisMapEditor`.
class LineOptions {
  /// The width of the line.
  final double strokeWidth;

  /// The main color of the line.
  final Color color;

  /// The width of the border around the line.
  final double borderStrokeWidth;

  /// The color of the border around the line.
  final Color? borderColor;

  /// Optional list of colors for a gradient along the line.
  final List<Color>? gradientColors;

  /// Optional list of stop positions for the gradient colors.
  final List<double>? colorsStop;

  /// Whether to draw the line as a dotted line.
  final bool isDotted;

  /// The style of the ends of the line.
  final StrokeCap strokeCap;

  /// The style of the corners where line segments meet.
  final StrokeJoin strokeJoin;

  /// Whether to interpret the strokeWidth as meters instead of pixels.
  final bool useStrokeWidthInMeter;

  /// Default constructor for `LineOptions`.
  const LineOptions({
    required this.strokeWidth,
    required this.color,
    this.borderStrokeWidth = 0.0,
    this.borderColor = Colors.blue,
    this.gradientColors,
    this.colorsStop,
    this.isDotted = false,
    this.strokeCap = StrokeCap.round,
    this.strokeJoin = StrokeJoin.round,
    this.useStrokeWidthInMeter = false,
  });

  /// Creates a copy of this `LineOptions` object with optional overrides.
  LineOptions copyWith({
    double? strokeWidth,
    Color? color,
    double? borderStrokeWidth,
    Color? borderColor,
    List<Color>? gradientColors,
    List<double>? colorsStop,
    bool? isDotted,
    StrokeCap? strokeCap,
    StrokeJoin? strokeJoin,
    bool? useStrokeWidthInMeter,
  }) {
    return LineOptions(
      strokeWidth: strokeWidth ?? this.strokeWidth,
      color: color ?? this.color,
      borderStrokeWidth: borderStrokeWidth ?? this.borderStrokeWidth,
      borderColor: borderColor ?? this.borderColor,
      gradientColors: gradientColors ?? this.gradientColors,
      colorsStop: colorsStop ?? this.colorsStop,
      isDotted: isDotted ?? this.isDotted,
      strokeCap: strokeCap ?? this.strokeCap,
      strokeJoin: strokeJoin ?? this.strokeJoin,
      useStrokeWidthInMeter:
          useStrokeWidthInMeter ?? this.useStrokeWidthInMeter,
    );
  }
}
