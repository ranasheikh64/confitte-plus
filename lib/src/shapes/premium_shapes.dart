import 'dart:math';
import 'package:flutter/material.dart';
import 'confettie_shape.dart';

/// A 4-pointed sparkle / glitter shape ✦
class SparkleShape extends ConfettieShape {
  final int points;
  const SparkleShape({this.points = 4});

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final r = size / 2;
    final path = Path();
    final total = points * 2;
    for (int i = 0; i < total; i++) {
      final isOuter = i.isEven;
      final radius = isOuter ? r : r * 0.18;
      final angle = (2 * pi * i) / total - pi / 2;
      final pt = Offset(radius * cos(angle), radius * sin(angle));
      if (i == 0) {
        path.moveTo(pt.dx, pt.dy);
      } else {
        path.lineTo(pt.dx, pt.dy);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }
}

/// A comet / shooting star 🌠
class CometShape extends ConfettieShape {
  const CometShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final r = size / 2;
    // Head
    canvas.drawCircle(Offset(r * 0.4, -r * 0.4), r * 0.3, paint);
    // Tail
    final tailPaint = Paint()
      ..color = paint.color.withValues(alpha: 0.5)
      ..strokeWidth = size * 0.12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final path = Path()
      ..moveTo(r * 0.4, -r * 0.4)
      ..cubicTo(-r * 0.1, r * 0.1, -r * 0.6, r * 0.3, -r, r * 0.6);
    canvas.drawPath(path, tailPaint);
  }
}

/// A crown 👑
class CrownShape extends ConfettieShape {
  const CrownShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final s = size / 2;
    final path = Path()
      // Base band
      ..moveTo(-s, s * 0.4)
      ..lineTo(s, s * 0.4)
      ..lineTo(s, s)
      ..lineTo(-s, s)
      ..close();
    canvas.drawPath(path, paint);

    // Crown spikes
    final spikes = Path()
      ..moveTo(-s, s * 0.4)
      ..lineTo(-s, -s)
      ..lineTo(-s * 0.33, -s * 0.1)
      ..lineTo(0, -s)
      ..lineTo(s * 0.33, -s * 0.1)
      ..lineTo(s, -s)
      ..lineTo(s, s * 0.4)
      ..close();
    canvas.drawPath(spikes, paint);
  }
}

/// A butterfly 🦋
class ButterflyShape extends ConfettieShape {
  const ButterflyShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final s = size / 2;
    final path = Path();

    // Top-left wing
    path.moveTo(0, 0);
    path.cubicTo(-s * 1.2, -s, -s * 1.4, s * 0.5, 0, s * 0.4);

    // Top-right wing
    path.moveTo(0, 0);
    path.cubicTo(s * 1.2, -s, s * 1.4, s * 0.5, 0, s * 0.4);

    // Bottom-left wing
    path.moveTo(0, s * 0.4);
    path.cubicTo(-s * 0.8, s * 0.3, -s * 0.9, s * 1.1, 0, s * 0.9);

    // Bottom-right wing
    path.moveTo(0, s * 0.4);
    path.cubicTo(s * 0.8, s * 0.3, s * 0.9, s * 1.1, 0, s * 0.9);

    canvas.drawPath(path, paint);

    // Body
    final bodyPaint = Paint()
      ..color = paint.color.withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(center: Offset(0, s * 0.45), width: s * 0.2, height: s),
      bodyPaint,
    );
  }
}

/// A music note ♪
class MusicNoteShape extends ConfettieShape {
  const MusicNoteShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final s = size / 2;
    // Note head (oval)
    canvas.save();
    canvas.rotate(-0.4);
    canvas.drawOval(
      Rect.fromCenter(center: Offset(-s * 0.1, s * 0.6), width: s * 0.9, height: s * 0.65),
      paint,
    );
    canvas.restore();

    // Stem
    final stemPaint = Paint()
      ..color = paint.color
      ..strokeWidth = size * 0.12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(s * 0.3, s * 0.3), Offset(s * 0.3, -s), stemPaint);

    // Flag
    final flagPath = Path()
      ..moveTo(s * 0.3, -s)
      ..cubicTo(s * 1.0, -s * 0.8, s * 0.9, -s * 0.2, s * 0.3, -s * 0.3);
    canvas.drawPath(flagPath, stemPaint);
  }
}

/// A balloon 🎈
class BalloonShape extends ConfettieShape {
  const BalloonShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final s = size / 2;
    // Balloon body
    canvas.drawOval(
      Rect.fromCenter(center: Offset(0, -s * 0.2), width: s * 1.6, height: s * 1.8),
      paint,
    );
    // Knot
    final knotPaint = Paint()
      ..color = paint.color.withValues(alpha: 0.8)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(0, s * 0.7), s * 0.15, knotPaint);
    // String
    final stringPaint = Paint()
      ..color = paint.color.withValues(alpha: 0.5)
      ..strokeWidth = size * 0.08
      ..style = PaintingStyle.stroke;
    final stringPath = Path()
      ..moveTo(0, s * 0.85)
      ..cubicTo(s * 0.3, s * 1.0, -s * 0.2, s * 1.2, 0, s * 1.4);
    canvas.drawPath(stringPath, stringPaint);
  }
}

/// A flame / fire 🔥
class FlameShape extends ConfettieShape {
  const FlameShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final r = size / 2;
    final path = Path()
      ..moveTo(0, r)
      ..cubicTo(-r * 0.8, r * 0.4, -r * 0.6, -r * 0.2, 0, -r)
      ..cubicTo(r * 0.3, -r * 0.5, r * 0.5, r * 0.1, r * 0.3, r * 0.5)
      ..cubicTo(r * 0.1, r * 0.2, -r * 0.2, r * 0.4, 0, r)
      ..close();
    canvas.drawPath(path, paint);
  }
}

/// A gem / faceted crystal 💠
class GemShape extends ConfettieShape {
  const GemShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final s = size / 2;
    // Top crown
    final path = Path()
      ..moveTo(-s * 0.3, 0)
      ..lineTo(-s, -s * 0.4)
      ..lineTo(-s * 0.4, -s)
      ..lineTo(0, -s * 0.7)
      ..lineTo(s * 0.4, -s)
      ..lineTo(s, -s * 0.4)
      ..lineTo(s * 0.3, 0)
      ..close();
    canvas.drawPath(path, paint);

    // Bottom pavilion
    final bottom = Path()
      ..moveTo(-s * 0.3, 0)
      ..lineTo(s * 0.3, 0)
      ..lineTo(0, s)
      ..close();
    final bottomPaint = Paint()
      ..color = paint.color.withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;
    canvas.drawPath(bottom, bottomPaint);
  }
}

/// A lucky clover / shamrock 🍀
class CloverShape extends ConfettieShape {
  const CloverShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final r = size / 2 * 0.55;
    // 4 petal circles
    final offsets = [
      Offset(0, -r * 0.9),
      Offset(r * 0.9, 0),
      Offset(0, r * 0.9),
      Offset(-r * 0.9, 0),
    ];
    for (final o in offsets) {
      canvas.drawCircle(o, r, paint);
    }
    // Stem
    final stemPaint = Paint()
      ..color = paint.color
      ..strokeWidth = size * 0.12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(0, r * 0.5), Offset(0, size * 0.7), stemPaint);
  }
}

/// A sun ☀️
class SunShape extends ConfettieShape {
  final int rays;
  const SunShape({this.rays = 8});

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final r = size / 2;
    // Rays
    final rayPaint = Paint()
      ..color = paint.color
      ..strokeWidth = size * 0.1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < rays; i++) {
      final angle = (2 * pi * i) / rays;
      canvas.drawLine(
        Offset(r * 0.55 * cos(angle), r * 0.55 * sin(angle)),
        Offset(r * cos(angle), r * sin(angle)),
        rayPaint,
      );
    }
    // Center circle
    canvas.drawCircle(Offset.zero, r * 0.45, paint);
  }
}

/// A planet with ring 🪐
class PlanetShape extends ConfettieShape {
  const PlanetShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final r = size / 2;
    // Planet body
    canvas.drawCircle(Offset.zero, r * 0.55, paint);
    // Ring
    final ringPaint = Paint()
      ..color = paint.color.withValues(alpha: 0.6)
      ..strokeWidth = size * 0.1
      ..style = PaintingStyle.stroke;
    canvas.save();
    canvas.scale(1.0, 0.4);
    canvas.drawCircle(Offset.zero, r * 0.9, ringPaint);
    canvas.restore();
  }
}

/// A crystal / gem shard
class CrystalShard extends ConfettieShape {
  const CrystalShard();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final s = size / 2;
    final path = Path()
      ..moveTo(0, -s)
      ..lineTo(s * 0.5, -s * 0.2)
      ..lineTo(s * 0.7, s * 0.6)
      ..lineTo(0, s)
      ..lineTo(-s * 0.3, s * 0.5)
      ..lineTo(-s * 0.6, -s * 0.3)
      ..close();
    canvas.drawPath(path, paint);
  }
}

/// An explosion burst shape 💥
class BurstShape extends ConfettieShape {
  final int spikes;
  const BurstShape({this.spikes = 10});

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final r = size / 2;
    final inner = r * 0.55;
    final path = Path();
    for (int i = 0; i < spikes * 2; i++) {
      final radius = i.isEven ? r : inner;
      final angle = (pi * i) / spikes;
      final pt = Offset(radius * cos(angle), radius * sin(angle));
      if (i == 0) {
        path.moveTo(pt.dx, pt.dy);
      } else {
        path.lineTo(pt.dx, pt.dy);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }
}

/// A crinkle / zigzag ribbon
class CrinkleShape extends ConfettieShape {
  const CrinkleShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final s = size / 2;
    final path = Path();
    const segs = 6;
    final segW = (2 * s) / segs;
    path.moveTo(-s, -s * 0.15);
    for (int i = 0; i <= segs; i++) {
      final x = -s + i * segW;
      final y = (i.isEven ? -1 : 1) * s * 0.25;
      path.lineTo(x, y - s * 0.15);
    }
    for (int i = segs; i >= 0; i--) {
      final x = -s + i * segW;
      final y = (i.isEven ? -1 : 1) * s * 0.25;
      path.lineTo(x, y + s * 0.15);
    }
    path.close();
    canvas.drawPath(path, paint);
  }
}

/// A tiny ticket / badge
class TicketShape extends ConfettieShape {
  const TicketShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final s = size / 2;
    final path = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: s * 2, height: s * 1.1),
      Radius.circular(s * 0.2),
    );
    canvas.drawRRect(path, paint);
    // Notches
    final notchPaint = Paint()
      ..color = paint.color
      ..blendMode = BlendMode.clear;
    canvas.drawCircle(Offset(-s, 0), s * 0.2, notchPaint);
    canvas.drawCircle(Offset(s, 0), s * 0.2, notchPaint);
  }
}

/// A cloud ☁️
class CloudShape extends ConfettieShape {
  const CloudShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final r = size / 2;
    canvas.drawCircle(Offset(-r * 0.3, r * 0.1), r * 0.5, paint);
    canvas.drawCircle(Offset(r * 0.3, r * 0.1), r * 0.5, paint);
    canvas.drawCircle(Offset(0, -r * 0.1), r * 0.55, paint);
    canvas.drawCircle(Offset(-r * 0.7, r * 0.3), r * 0.35, paint);
    canvas.drawCircle(Offset(r * 0.7, r * 0.3), r * 0.35, paint);
    canvas.drawRect(
      Rect.fromCenter(center: Offset(0, r * 0.45), width: r * 1.5, height: r * 0.4),
      paint,
    );
  }
}

/// A paper plane ✈️
class PaperPlaneShape extends ConfettieShape {
  const PaperPlaneShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final s = size / 2;
    // Main body
    final body = Path()
      ..moveTo(s, 0)
      ..lineTo(-s, -s * 0.5)
      ..lineTo(-s * 0.4, 0)
      ..lineTo(-s, s * 0.5)
      ..close();
    canvas.drawPath(body, paint);
    // Wing fold line
    final foldPaint = Paint()
      ..color = paint.color.withValues(alpha: 0.4)
      ..strokeWidth = size * 0.08
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(-s * 0.4, 0), Offset(s * 0.4, 0), foldPaint);
  }
}

/// A peace symbol ✌️
class PeaceShape extends ConfettieShape {
  const PeaceShape();

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    final r = size / 2;
    final strokePaint = Paint()
      ..color = paint.color
      ..strokeWidth = size * 0.14
      ..style = PaintingStyle.stroke;
    // Outer circle
    canvas.drawCircle(Offset.zero, r, strokePaint);
    // Center line (vertical)
    canvas.drawLine(Offset(0, -r), Offset(0, r), strokePaint);
    // Two diagonal lines
    canvas.drawLine(Offset(0, 0), Offset(-r * cos(pi / 6), r * sin(pi / 6)), strokePaint);
    canvas.drawLine(Offset(0, 0), Offset(r * cos(pi / 6), r * sin(pi / 6)), strokePaint);
  }
}
