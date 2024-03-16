import 'package:flutter/material.dart';

/// widget for add space horizontal
class SpaceH extends StatelessWidget {
  /// constructor
  const SpaceH(this.size, {super.key});

  /// size in [double] for horizontal space
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size);
  }
}
