import 'package:flutter/material.dart';
import 'confettie_shape.dart';

/// A plus / cross confetti particle.
class CrossShape extends ConfettieShape {
  final double thickness;
  const CrossShape({this.thickness = 0.3});

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final s = size / 2;
    final t = s * thickness;
    final path = Path()
      // Vertical bar
      ..addRect(Rect.fromCenter(center: Offset.zero, width: t * 2, height: s * 2))
      // Horizontal bar
      ..addRect(Rect.fromCenter(center: Offset.zero, width: s * 2, height: t * 2));
    canvas.drawPath(path, paint);
  }
}

/// An X shape confetti particle.
class XShape extends ConfettieShape {
  const XShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final s = size / 2;
    final strokePaint = Paint()
      ..color = paint.color
      ..strokeWidth = size * 0.25
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(-s, -s), Offset(s, s), strokePaint);
    canvas.drawLine(Offset(s, -s), Offset(-s, s), strokePaint);
  }
}
