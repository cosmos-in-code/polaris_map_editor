import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

typedef PointBuilder = Widget Function(
  BuildContext context,
  LatLng point,
  bool isLast,
);

class PointOptions {
  final bool custom;
  final PointBuilder? builder;
  final Widget? icon;
  final Widget? lastPointIcon;

  PointOptions._({
    required this.custom,
    required this.builder,
    required this.icon,
    required this.lastPointIcon,
  }) : assert(custom && builder != null || !custom && icon != null);

  PointOptions({
    required this.icon,
    required this.lastPointIcon,
  })  : builder = null,
        custom = false;

  PointOptions.builder({
    required this.builder,
  })  : custom = true,
        icon = null,
        lastPointIcon = null;

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
