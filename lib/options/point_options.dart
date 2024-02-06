import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

// Define a type for a function that builds point widgets
typedef PointBuilder = Widget Function(
  BuildContext context,
  LatLng point,
  bool isLast,
);

class PointOptions {
  // Whether to use a custom builder function for points
  final bool custom;

  // Optional builder function for custom point rendering
  final PointBuilder? builder;

  // Optional icon to use for regular points
  final Widget? icon;

  // Optional icon to use for the last point in a sequence
  final Widget? lastPointIcon;

  // Private constructor to enforce constraints
  PointOptions._({
    required this.custom,
    required this.builder,
    required this.icon,
    required this.lastPointIcon,
  }) : assert(custom && builder != null || !custom && icon != null);

  // Public constructor for using pre-defined icons
  PointOptions({
    required this.icon,
    required this.lastPointIcon,
  })  : builder = null,
        custom = false;

  // Public constructor for using a custom builder function
  PointOptions.builder({
    required this.builder,
  })  : custom = true,
        icon = null,
        lastPointIcon = null;

  // Creates a copy of this object with optional overrides
  PointOptions copyWith({
    PointBuilder? builder,
    Widget? icon,
    Widget? lastPointIcon,
  }) {
    return PointOptions._(
      custom: custom,
      builder: builder ?? this.builder,
      icon: icon ?? this.icon,
      lastPointIcon: lastPointIcon ?? this.lastPointIcon,
    );
  }
}
