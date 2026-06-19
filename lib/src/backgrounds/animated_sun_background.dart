import 'dart:math';
import 'package:flutter/material.dart';

/// A naturally animated sun widget — perfect as a widget background or overlay.
///
/// ```dart
/// AnimatedSunBackground(
///   size: 200,
///   color: Color(0xFFFFD700),
///   child: YourWidget(),
/// )
/// ```
class AnimatedSunBackground extends StatefulWidget {
  /// The diameter of the sun (default 180).
  final double size;

  /// Primary sun color (default golden yellow).
  final Color color;

  /// Optional second color for gradient glow.
  final Color? glowColor;

  /// Number of rays (default 12).
  final int rayCount;

  /// Alignment of the sun within [child]. Defaults to topRight.
  final Alignment alignment;

  /// Optional child widget rendered below the sun.
  final Widget? child;

  /// Whether to show the animated glow halo.
  final bool showGlow;

  /// Speed multiplier (1.0 = normal). Higher = faster animation.
  final double speed;

  const AnimatedSunBackground({
    super.key,
    this.size = 180,
    this.color = const Color(0xFFFFD700),
    this.glowColor,
    this.rayCount = 12,
    this.alignment = Alignment.topRight,
    this.child,
    this.showGlow = true,
    this.speed = 1.0,
  });

  @override
  State<AnimatedSunBackground> createState() => _AnimatedSunBackgroundState();
}

class _AnimatedSunBackgroundState extends State<AnimatedSunBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _rotate;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(seconds: (12 / widget.speed).round()),
    )..repeat();

    _rotate = Tween<double>(begin: 0, end: 2 * pi).animate(_ctrl);
    _pulse = Tween<double>(begin: 0.97, end: 1.03).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.child != null) widget.child!,
        Align(
          alignment: widget.alignment,
          child: AnimatedBuilder(
            animation: _ctrl,
            builder: (_, __) => Transform.scale(
              scale: _pulse.value,
              child: SizedBox(
                width: widget.size,
                height: widget.size,
                child: CustomPaint(
                  painter: _SunPainter(
                    rotation: _rotate.value,
                    color: widget.color,
                    glowColor: widget.glowColor ?? widget.color.withValues(alpha: 0.3),
                    rayCount: widget.rayCount,
                    showGlow: widget.showGlow,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SunPainter extends CustomPainter {
  final double rotation;
  final Color color;
  final Color glowColor;
  final int rayCount;
  final bool showGlow;

  _SunPainter({
    required this.rotation,
    required this.color,
    required this.glowColor,
    required this.rayCount,
    required this.showGlow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;

    // Outer glow
    if (showGlow) {
      final glowPaint = Paint()
        ..shader = RadialGradient(colors: [
          color.withValues(alpha: 0.35),
          color.withValues(alpha: 0.12),
          Colors.transparent,
        ]).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: r));
      canvas.drawCircle(Offset(cx, cy), r, glowPaint);
    }

    // Rays
    canvas.save();
    canvas.translate(cx, cy);
    canvas.rotate(rotation);
    final rayPaint = Paint()
      ..color = color.withValues(alpha: 0.7)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < rayCount; i++) {
      final angle = (2 * pi * i) / rayCount;
      final innerR = r * 0.42;
      final outerR = r * (i.isEven ? 0.78 : 0.68);
      rayPaint.strokeWidth = r * (i.isEven ? 0.055 : 0.035);
      canvas.drawLine(
        Offset(innerR * cos(angle), innerR * sin(angle)),
        Offset(outerR * cos(angle), outerR * sin(angle)),
        rayPaint,
      );
    }
    canvas.restore();

    // Core body
    final bodyPaint = Paint()
      ..shader = RadialGradient(colors: [
        Color.lerp(Colors.white, color, 0.4)!,
        color,
        color.withValues(alpha: 0.85),
      ], stops: const [0.0, 0.6, 1.0])
          .createShader(Rect.fromCircle(center: Offset(cx * 0.85, cy * 0.85), radius: r * 0.4));
    canvas.drawCircle(Offset(cx, cy), r * 0.36, bodyPaint);
  }

  @override
  bool shouldRepaint(covariant _SunPainter old) => old.rotation != rotation;
}
