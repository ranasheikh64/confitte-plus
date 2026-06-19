import 'dart:math';
import 'package:flutter/material.dart';
import 'confettie_shape.dart';

/// A spiral / curled ribbon confetti particle 🎊
class SpiralShape extends ConfettieShape {
  final int turns;
  const SpiralShape({this.turns = 2});

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final r = size / 2;
    final path = Path();
    final steps = 60;
    final paintCopy = Paint()
      ..color = paint.color
      ..strokeWidth = size * 0.12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i <= steps; i++) {
      final t = i / steps;
      final angle = t * turns * 2 * pi;
      final radius = r * t;
      final x = radius * cos(angle);
      final y = radius * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paintCopy);
  }
}

/// A curly ribbon / streamer confetti particle.
class StreamerShape extends ConfettieShape {
  const StreamerShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final s = size / 2;
    final path = Path();
    path.moveTo(-s, -s);
    path.cubicTo(-s * 0.5, -s, s * 0.5, -s * 0.3, 0, 0);
    path.cubicTo(-s * 0.5, s * 0.3, s * 0.5, s, s, s);

    final strokePaint = Paint()
      ..color = paint.color
      ..strokeWidth = size * 0.15
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, strokePaint);
  }
}
