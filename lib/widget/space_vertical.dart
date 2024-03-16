import 'package:flutter/material.dart';

/// widget for add space horizontal
class SpaceV extends StatelessWidget {
  /// constructor
  const SpaceV(this.size, {super.key});

  /// size in [double] for vertical space
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size);
  }
}
