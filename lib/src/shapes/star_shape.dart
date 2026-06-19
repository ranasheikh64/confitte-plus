import 'dart:math';
import 'package:flutter/material.dart';
import 'confettie_shape.dart';

/// A classic 5-pointed star confetti particle.
class StarShape extends ConfettieShape {
  /// Number of points on the star (default 5).
  final int points;

  /// How deep the inner notch goes. 0.5 = classic star, 0.3 = sharper.
  final double innerRadiusRatio;

  const StarShape({this.points = 5, this.innerRadiusRatio = 0.4});

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final path = _buildStarPath(size / 2);
    canvas.drawPath(path, paint);
  }

  Path _buildStarPath(double outerRadius) {
    final innerRadius = outerRadius * innerRadiusRatio;
    final path = Path();
    final totalPoints = points * 2;
    for (int i = 0; i < totalPoints; i++) {
      final r = i.isEven ? outerRadius : innerRadius;
      final angle = (i * pi) / points - pi / 2;
      final point = Offset(r * cos(angle), r * sin(angle));
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    return path;
  }
}

/// A 6-pointed snowflake-style star.
class SnowflakeShape extends ConfettieShape {
  const SnowflakeShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final r = size / 2;
    // 3 crossing lines forming a snowflake
    paint.strokeWidth = size * 0.15;
    paint.style = PaintingStyle.stroke;
    for (int i = 0; i < 3; i++) {
      final angle = (i * pi) / 3;
      canvas.drawLine(
        Offset(r * cos(angle), r * sin(angle)),
        Offset(-r * cos(angle), -r * sin(angle)),
        paint,
      );
    }
    paint.style = PaintingStyle.fill;
  }
}
