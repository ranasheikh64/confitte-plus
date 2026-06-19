import 'dart:math';
import 'package:flutter/material.dart';
import 'confettie_shape.dart';

/// A wavy / sinusoidal ribbon confetti particle.
class WaveShape extends ConfettieShape {
  final int waveCount;
  const WaveShape({this.waveCount = 3});

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final r = size / 2;
    final path = Path();
    const steps = 40;

    // Top wave edge
    for (int i = 0; i <= steps; i++) {
      final t = i / steps;
      final x = -r + t * 2 * r;
      final y = -r * 0.3 * sin(t * waveCount * 2 * pi);
      if (i == 0) {
        path.moveTo(x, y - r * 0.15);
      } else {
        path.lineTo(x, y - r * 0.15);
      }
    }

    // Bottom wave edge (reversed)
    for (int i = steps; i >= 0; i--) {
      final t = i / steps;
      final x = -r + t * 2 * r;
      final y = -r * 0.3 * sin(t * waveCount * 2 * pi);
      path.lineTo(x, y + r * 0.15);
    }

    path.close();
    canvas.drawPath(path, paint);
  }
}
