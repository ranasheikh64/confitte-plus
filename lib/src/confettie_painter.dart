import 'package:flutter/material.dart';
import 'models/confettie_particle.dart';

/// Efficient CustomPainter that draws all confetti particles.
class ConfettiePainter extends CustomPainter {
  final List<ConfettieParticle> particles;

  ConfettiePainter({required this.particles});

  // Reuse a single Paint object to avoid GC pressure
  final Paint _paint = Paint()..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      if (p.opacity <= 0) continue;

      _paint.color = p.color.withValues(alpha: p.opacity.clamp(0.0, 1.0));

      canvas.save();
      canvas.translate(p.x, p.y);
      canvas.rotate(p.rotation);

      p.shape.draw(canvas, _paint, p.size);

      canvas.restore();
    }
  }

  /// Always repaint — particles move every frame.
  @override
  bool shouldRepaint(covariant ConfettiePainter oldDelegate) => true;
}
