import 'package:flutter/material.dart';
import 'confettie_shape.dart';

/// A teardrop confetti particle.
class TeardropShape extends ConfettieShape {
  const TeardropShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final r = size / 2;
    final path = Path();
    // Pointed bottom, round top
    path.moveTo(0, r);
    path.cubicTo(r, r * 0.5, r, -r * 0.3, 0, -r);
    path.cubicTo(-r, -r * 0.3, -r, r * 0.5, 0, r);
    path.close();
    canvas.drawPath(path, paint);
  }
}

/// A leaf confetti particle 🍃
class LeafShape extends ConfettieShape {
  const LeafShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final r = size / 2;
    final path = Path();
    path.moveTo(0, -r);
    path.cubicTo(r, -r * 0.5, r * 0.8, r * 0.5, 0, r);
    path.cubicTo(-r * 0.8, r * 0.5, -r, -r * 0.5, 0, -r);
    path.close();
    canvas.drawPath(path, paint);

    // Midrib
    final strokePaint = Paint()
      ..color = paint.color.withValues(alpha: 0.5)
      ..strokeWidth = size * 0.08
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(0, -r), Offset(0, r), strokePaint);
  }
}
