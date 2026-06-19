import 'dart:math';
import 'package:flutter/material.dart';
import 'confettie_shape.dart';

/// A triangle confetti particle.
class TriangleShape extends ConfettieShape {
  const TriangleShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final r = size / 2;
    final path = Path();
    for (int i = 0; i < 3; i++) {
      final angle = (2 * pi * i / 3) - pi / 2;
      final point = Offset(r * cos(angle), r * sin(angle));
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }
}

/// An arrow confetti particle.
class ArrowShape extends ConfettieShape {
  const ArrowShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final s = size / 2;
    final path = Path()
      ..moveTo(0, -s)
      ..lineTo(s * 0.6, 0)
      ..lineTo(s * 0.25, 0)
      ..lineTo(s * 0.25, s)
      ..lineTo(-s * 0.25, s)
      ..lineTo(-s * 0.25, 0)
      ..lineTo(-s * 0.6, 0)
      ..close();
    canvas.drawPath(path, paint);
  }
}

/// A lightning bolt confetti particle ⚡
class LightningShape extends ConfettieShape {
  const LightningShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final s = size / 2;
    final path = Path()
      ..moveTo(s * 0.3, -s)
      ..lineTo(-s * 0.1, -s * 0.05)
      ..lineTo(s * 0.3, -s * 0.05)
      ..lineTo(-s * 0.3, s)
      ..lineTo(s * 0.1, s * 0.05)
      ..lineTo(-s * 0.3, s * 0.05)
      ..close();
    canvas.drawPath(path, paint);
  }
}
