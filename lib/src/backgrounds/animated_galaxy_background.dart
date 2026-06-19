import 'dart:math';
import 'package:flutter/material.dart';

/// A naturally animated galaxy / deep space background.
///
/// ```dart
/// AnimatedGalaxyBackground(
///   starCount: 200,
///   primaryColor: Color(0xFF7C3AED),
///   child: YourWidget(),
/// )
/// ```
class AnimatedGalaxyBackground extends StatefulWidget {
  /// Number of stars (default 150).
  final int starCount;

  /// Number of shooting stars (default 3).
  final int shootingStarCount;

  /// Primary nebula color.
  final Color primaryColor;

  /// Secondary nebula color.
  final Color secondaryColor;

  /// If true, renders a spiral galaxy center.
  final bool showNebula;

  /// Optional child rendered over the galaxy.
  final Widget? child;

  /// Speed of star twinkling and shooting stars.
  final double speed;

  /// Galaxy center alignment.
  final Alignment nebulaAlignment;

  const AnimatedGalaxyBackground({
    super.key,
    this.starCount = 150,
    this.shootingStarCount = 3,
    this.primaryColor = const Color(0xFF7C3AED),
    this.secondaryColor = const Color(0xFF1E3A5F),
    this.showNebula = true,
    this.child,
    this.speed = 1.0,
    this.nebulaAlignment = Alignment.center,
  });

  @override
  State<AnimatedGalaxyBackground> createState() => _AnimatedGalaxyBackgroundState();
}

class _AnimatedGalaxyBackgroundState extends State<AnimatedGalaxyBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late List<_GalaxyStar> _stars;
  late List<_ShootingStar> _shooters;
  final Random _rnd = Random(7);

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(seconds: (8 / widget.speed).round()),
    )..repeat();

    _stars = List.generate(widget.starCount, (_) => _GalaxyStar(_rnd));
    _shooters = List.generate(widget.shootingStarCount, (_) => _ShootingStar(_rnd));
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
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _ctrl,
            builder: (_, __) => CustomPaint(
              painter: _GalaxyPainter(
                stars: _stars,
                shooters: _shooters,
                progress: _ctrl.value,
                primaryColor: widget.primaryColor,
                secondaryColor: widget.secondaryColor,
                showNebula: widget.showNebula,
                nebulaAlignment: widget.nebulaAlignment,
              ),
            ),
          ),
        ),
        if (widget.child != null) widget.child!,
      ],
    );
  }
}

class _GalaxyStar {
  final double x, y, size, phase, brightness;
  _GalaxyStar(Random rnd)
      : x = rnd.nextDouble(),
        y = rnd.nextDouble(),
        size = 0.4 + rnd.nextDouble() * 2.2,
        phase = rnd.nextDouble() * 2 * pi,
        brightness = 0.4 + rnd.nextDouble() * 0.6;
}

class _ShootingStar {
  double x, y, vx, vy, life, maxLife;

  _ShootingStar(Random rnd)
      : x = rnd.nextDouble(),
        y = rnd.nextDouble() * 0.5,
        vx = 0.003 + rnd.nextDouble() * 0.004,
        vy = 0.002 + rnd.nextDouble() * 0.003,
        life = rnd.nextDouble(),
        maxLife = 0.6 + rnd.nextDouble() * 0.4;

  void update(double dt, Random rnd) {
    life += dt * 0.8;
    x += vx;
    y += vy;
    if (life > maxLife || x > 1.1 || y > 1.1) {
      x = rnd.nextDouble() * 0.4;
      y = rnd.nextDouble() * 0.4;
      vx = 0.003 + rnd.nextDouble() * 0.004;
      vy = 0.002 + rnd.nextDouble() * 0.003;
      life = 0;
      maxLife = 0.6 + rnd.nextDouble() * 0.4;
    }
  }
}

class _GalaxyPainter extends CustomPainter {
  final List<_GalaxyStar> stars;
  final List<_ShootingStar> shooters;
  final double progress;
  final Color primaryColor;
  final Color secondaryColor;
  final bool showNebula;
  final Alignment nebulaAlignment;

  _GalaxyPainter({
    required this.stars,
    required this.shooters,
    required this.progress,
    required this.primaryColor,
    required this.secondaryColor,
    required this.showNebula,
    required this.nebulaAlignment,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = Random(42);

    // Nebula glow
    if (showNebula) {
      final nx = (nebulaAlignment.x + 1) / 2 * size.width;
      final ny = (nebulaAlignment.y + 1) / 2 * size.height;
      final nr = size.shortestSide * 0.6;

      final paint1 = Paint()
        ..shader = RadialGradient(colors: [
          primaryColor.withValues(alpha: 0.22),
          primaryColor.withValues(alpha: 0.08),
          Colors.transparent,
        ]).createShader(Rect.fromCircle(center: Offset(nx, ny), radius: nr));
      canvas.drawCircle(Offset(nx, ny), nr, paint1);

      final paint2 = Paint()
        ..shader = RadialGradient(colors: [
          secondaryColor.withValues(alpha: 0.18),
          secondaryColor.withValues(alpha: 0.06),
          Colors.transparent,
        ]).createShader(Rect.fromCircle(center: Offset(nx + nr * 0.3, ny - nr * 0.2), radius: nr * 0.7));
      canvas.drawCircle(Offset(nx + nr * 0.3, ny - nr * 0.2), nr * 0.7, paint2);
    }

    // Stars
    final starPaint = Paint()..style = PaintingStyle.fill;
    for (final s in stars) {
      final twinkle = s.brightness * (0.5 + 0.5 * sin(progress * 2 * pi + s.phase));
      starPaint.color = Colors.white.withValues(alpha: twinkle);
      canvas.drawCircle(Offset(s.x * size.width, s.y * size.height), s.size, starPaint);
    }

    // Shooting stars
    final shootPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (final sh in shooters) {
      sh.update(1 / 60, rnd);
      final alpha = (1 - sh.life / sh.maxLife).clamp(0.0, 0.8);
      if (alpha <= 0) continue;
      shootPaint
        ..color = Colors.white.withValues(alpha: alpha)
        ..strokeWidth = 1.5;
      final tx = sh.x * size.width;
      final ty = sh.y * size.height;
      final tailLen = size.width * 0.06;
      canvas.drawLine(
        Offset(tx - sh.vx * tailLen / sh.vx, ty - sh.vy * tailLen / sh.vx),
        Offset(tx, ty),
        shootPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GalaxyPainter old) => old.progress != progress;
}
