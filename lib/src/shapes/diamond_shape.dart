import 'dart:math';
import 'package:flutter/material.dart';
import 'confettie_shape.dart';

/// A diamond (rhombus) confetti particle 💎
class DiamondShape extends ConfettieShape {
  const DiamondShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final s = size / 2;
    final path = Path()
      ..moveTo(0, -s)
      ..lineTo(s * 0.6, 0)
      ..lineTo(0, s)
      ..lineTo(-s * 0.6, 0)
      ..close();
    canvas.drawPath(path, paint);
  }
}

/// A hexagon confetti particle.
class HexagonShape extends ConfettieShape {
  const HexagonShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final r = size / 2;
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (pi / 3) * i;
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

/// A pentagon confetti particle.
class PentagonShape extends ConfettieShape {
  const PentagonShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final r = size / 2;
    final path = Path();
    for (int i = 0; i < 5; i++) {
      final angle = (2 * pi * i / 5) - pi / 2;
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
