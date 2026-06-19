import 'dart:math';
import 'package:flutter/material.dart';
import 'confettie_shape.dart';

/// A heart-shaped confetti particle ❤️
class HeartShape extends ConfettieShape {
  const HeartShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final s = size / 2;
    final path = Path();

    // Classic heart bezier curve
    path.moveTo(0, s * 0.3);

    // Left lobe
    path.cubicTo(
      -s * 0.1, -s * 0.2,
      -s, -s * 0.1,
      -s, s * 0.3,
    );
    path.cubicTo(
      -s, s * 0.7,
      -s * 0.5, s * 1.0,
      0, s * 1.3,
    );

    // Right lobe
    path.cubicTo(
      s * 0.5, s * 1.0,
      s, s * 0.7,
      s, s * 0.3,
    );
    path.cubicTo(
      s, -s * 0.1,
      s * 0.1, -s * 0.2,
      0, s * 0.3,
    );

    path.close();

    // Center the heart
    canvas.save();
    canvas.translate(0, -s * 0.3);
    canvas.drawPath(path, paint);
    canvas.restore();
  }
}

/// A tiny bow / ribbon confetti particle 🎀
class BowShape extends ConfettieShape {
  const BowShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final s = size / 2;
    final path = Path();

    // Left wing
    path.moveTo(0, 0);
    path.cubicTo(-s, -s, -s * 1.5, -s * 0.5, -s, 0);
    path.cubicTo(-s * 1.5, s * 0.5, -s, s, 0, 0);

    // Right wing
    path.moveTo(0, 0);
    path.cubicTo(s, -s, s * 1.5, -s * 0.5, s, 0);
    path.cubicTo(s * 1.5, s * 0.5, s, s, 0, 0);

    canvas.drawPath(path, paint);
    canvas.drawCircle(Offset.zero, s * 0.2, paint);
  }
}

/// A crescent moon confetti particle 🌙
class MoonShape extends ConfettieShape {
  const MoonShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final r = size / 2;
    final path = Path();

    path.addOval(Rect.fromCircle(center: Offset.zero, radius: r));

    // Cut out inner circle offset to create crescent
    path.addOval(
      Rect.fromCircle(center: Offset(r * 0.4, -r * 0.1), radius: r * 0.75),
    );
    path.fillType = PathFillType.evenOdd;
    canvas.drawPath(path, paint);
  }
}

/// A flower petal confetti particle 🌸
class FlowerShape extends ConfettieShape {
  final int petals;
  const FlowerShape({this.petals = 5});

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final r = size / 2;
    final path = Path();

    for (int i = 0; i < petals; i++) {
      final angle = (2 * pi * i) / petals;
      final cx = r * 0.4 * cos(angle);
      final cy = r * 0.4 * sin(angle);
      path.addOval(Rect.fromCenter(
        center: Offset(cx, cy),
        width: r * 0.8,
        height: r * 0.5,
      ));
    }
    canvas.drawPath(path, paint);
    canvas.drawCircle(Offset.zero, r * 0.2, paint);
  }
}
