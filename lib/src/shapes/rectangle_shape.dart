import 'package:flutter/material.dart';
import 'confettie_shape.dart';

/// A rectangular confetti particle — the classic confetti look.
class RectangleShape extends ConfettieShape {
  /// Aspect ratio of the rectangle. Default 0.5 gives a flat strip look.
  final double aspectRatio;

  const RectangleShape({this.aspectRatio = 0.5});

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset.zero,
        width: size,
        height: size * aspectRatio,
      ),
      paint,
    );
  }
}

/// A square confetti particle.
class SquareShape extends ConfettieShape {
  const SquareShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    canvas.drawRect(
      Rect.fromCenter(center: Offset.zero, width: size, height: size),
      paint,
    );
  }
}

/// A rounded-rectangle confetti particle.
class RoundedRectShape extends ConfettieShape {
  final double radius;
  const RoundedRectShape({this.radius = 3.0});

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset.zero, width: size, height: size * 0.5),
        Radius.circular(radius),
      ),
      paint,
    );
  }
}
