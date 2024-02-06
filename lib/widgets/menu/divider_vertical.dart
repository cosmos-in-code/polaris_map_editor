import 'package:flutter/material.dart';

class DividerVertical extends StatelessWidget {
  final double height;

  const DividerVertical({
    super.key,
    this.height = 32.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.6,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: Colors.grey[400],
    );
  }
}
