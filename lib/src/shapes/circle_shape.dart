import 'package:flutter/material.dart';
import 'confettie_shape.dart';

/// A circular confetti particle.
class CircleShape extends ConfettieShape {
  const CircleShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    canvas.drawCircle(Offset.zero, size / 2, paint);
  }
}

/// A donut (ring) confetti particle.
class DonutShape extends ConfettieShape {
  final double holeRatio;
  const DonutShape({this.holeRatio = 0.5});

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final outerR = size / 2;
    final innerR = outerR * holeRatio;
    final path = Path()
      ..addOval(Rect.fromCircle(center: Offset.zero, radius: outerR))
      ..addOval(Rect.fromCircle(center: Offset.zero, radius: innerR));
    path.fillType = PathFillType.evenOdd;
    canvas.drawPath(path, paint);
  }
}
