import 'package:flutter/material.dart';

/// gradient for welcome page
final Gradient gradientAppBackground = LinearGradient(
  colors: [
    const Color(0xFF2C2C2B).withAlpha(20),
    Colors.black.withOpacity(0.8),
  ],
  begin: Alignment.topCenter,
  end: Alignment.center,
  stops: const [0.1, 0.9],
);
