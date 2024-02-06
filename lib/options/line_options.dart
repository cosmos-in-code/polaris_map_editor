import 'package:flutter/material.dart';

class LineOptions {
  final double strokeWidth;
  final Color color;
  final double borderStrokeWidth;
  final Color? borderColor;
  final List<Color>? gradientColors;
  final List<double>? colorsStop;
  final bool isDotted;
  final StrokeCap strokeCap;
  final StrokeJoin strokeJoin;
  final bool useStrokeWidthInMeter;

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
