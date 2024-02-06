import 'package:flutter/material.dart';

/// Vertical divider widget with customizable height.

class DividerVertical extends StatelessWidget {
  /// The desired height of the divider in pixels.
  final double height;

  /// Creates a DividerVertical with the specified height.
  const DividerVertical({
    super.key,
    this.height = 32.0,
  });

  @override
  Widget build(BuildContext context) {
    /// Defines a container with divider styling.
    return Container(
      width: 0.6, // Thin width
      height: height,
      margin:
          const EdgeInsets.symmetric(horizontal: 8), // Adds horizontal padding
      color: Colors.grey[400], // Light gray color
    );
  }
}
