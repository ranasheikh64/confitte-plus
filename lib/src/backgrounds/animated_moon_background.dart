import 'dart:math';
import 'package:flutter/material.dart';

/// Predefined moon phases for [AnimatedMoonBackground].
///
/// ```dart
/// AnimatedMoonBackground(moonPhase: MoonPhase.full)
/// AnimatedMoonBackground(moonPhase: MoonPhase.half)
/// AnimatedMoonBackground(moonPhase: MoonPhase.crescent)
/// ```
enum MoonPhase {
  /// Full moon — completely visible circle.
  full,

  /// Waxing gibbous — about 75% visible.
  gibbous,

  /// Half moon — exactly 50% visible (first quarter).
  half,

  /// Crescent — about 25% visible sliver.
  crescent,

  /// Thin crescent — very thin sliver.
  thinCrescent;

  /// Returns the numeric phase value used by the painter.
  /// 0.0 = full circle visible, higher = more cut away.
  double get phaseValue {
    switch (this) {
      case MoonPhase.full:
        return 0.0;
      case MoonPhase.gibbous:
        return 0.15;
      case MoonPhase.half:
        return 0.45;
      case MoonPhase.crescent:
        return 0.70;
      case MoonPhase.thinCrescent:
        return 0.88;
    }
  }

  String get label {
    switch (this) {
      case MoonPhase.full:
        return 'Full Moon';
      case MoonPhase.gibbous:
        return 'Gibbous';
      case MoonPhase.half:
        return 'Half Moon';
      case MoonPhase.crescent:
        return 'Crescent';
      case MoonPhase.thinCrescent:
        return 'Thin';
    }
  }

  String get emoji {
    switch (this) {
      case MoonPhase.full:
        return '🌕';
      case MoonPhase.gibbous:
        return '🌔';
      case MoonPhase.half:
        return '🌓';
      case MoonPhase.crescent:
        return '🌒';
      case MoonPhase.thinCrescent:
        return '🌑';
    }
  }
}

/// A naturally animated moon widget with twinkling stars, craters, and glow.
///
/// ## Quick examples
/// ```dart
/// // Full moon
/// AnimatedMoonBackground(
///   moonPhase: MoonPhase.full,
///   size: 200,
///   child: YourWidget(),
/// )
///
/// // Half moon
/// AnimatedMoonBackground(
///   moonPhase: MoonPhase.half,
///   moonColor: Color(0xFFFFF8DC),
///   child: YourWidget(),
/// )
///
/// // Custom phase (0.0 = full, 0.9 = thin crescent)
/// AnimatedMoonBackground(phase: 0.5, child: YourWidget())
/// ```
class AnimatedMoonBackground extends StatefulWidget {
  /// Diameter of the moon (default 160).
  final double size;

  /// Moon color (default warm white).
  final Color moonColor;

  /// Optional glow color around the moon.
  final Color? glowColor;

  /// Where to place the moon (default topRight).
  final Alignment alignment;

  /// Number of twinkling stars (default 30).
  final int starCount;

  /// Optional child rendered behind the moon.
  final Widget? child;

  /// Speed multiplier for animations. (default 1.0)
  final double speed;

  /// Named moon phase. Overrides [phase] if provided.
  ///
  /// Use [MoonPhase.full], [MoonPhase.half], [MoonPhase.crescent], etc.
  final MoonPhase? moonPhase;

  /// Raw phase value — 0.0 = full moon, ~0.9 = thin crescent.
  ///
  /// Ignored when [moonPhase] is set.
  final double phase;

  const AnimatedMoonBackground({
    super.key,
    this.size = 160,
    this.moonColor = const Color(0xFFFFF8E7),
    this.glowColor,
    this.alignment = Alignment.topRight,
    this.starCount = 30,
    this.child,
    this.speed = 1.0,
    this.moonPhase,
    this.phase = 0.25,
  });

  @override
  State<AnimatedMoonBackground> createState() => _AnimatedMoonBackgroundState();
}

class _AnimatedMoonBackgroundState extends State<AnimatedMoonBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late List<_StarData> _stars;
  final Random _rnd = Random(42);

  double get _effectivePhase => widget.moonPhase?.phaseValue ?? widget.phase;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(seconds: (6 / widget.speed).round()),
    )..repeat(reverse: true);

    _stars = List.generate(widget.starCount, (_) => _StarData(_rnd));
  }

  @override
  void didUpdateWidget(AnimatedMoonBackground old) {
    super.didUpdateWidget(old);
    if (old.speed != widget.speed) {
      _ctrl.duration = Duration(seconds: (6 / widget.speed).round());
    }
    if (old.starCount != widget.starCount) {
      _stars = List.generate(widget.starCount, (_) => _StarData(_rnd));
    }
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
        // Starfield (only when starCount > 0)
        if (widget.starCount > 0)
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _ctrl,
              builder: (_, __) => CustomPaint(
                painter: _StarfieldPainter(
                  stars: _stars,
                  progress: _ctrl.value,
                  moonColor: widget.moonColor,
                ),
              ),
            ),
          ),
        // Moon body
        Align(
          alignment: widget.alignment,
          child: AnimatedBuilder(
            animation: _ctrl,
            builder: (_, __) {
              final glow = 0.97 + 0.05 * sin(_ctrl.value * pi);
              return Transform.scale(
                scale: glow,
                child: SizedBox(
                  width: widget.size,
                  height: widget.size,
                  child: CustomPaint(
                    painter: _MoonPainter(
                      color: widget.moonColor,
                      glowColor: widget.glowColor ??
                          widget.moonColor.withValues(alpha: 0.28),
                      phase: _effectivePhase,
                      glowScale: glow,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────
// Star data
// ─────────────────────────────────────────────────────
class _StarData {
  final double x, y, size, phase;
  _StarData(Random rnd)
      : x = rnd.nextDouble(),
        y = rnd.nextDouble(),
        size = 0.5 + rnd.nextDouble() * 2.5,
        phase = rnd.nextDouble() * 2 * pi;
}

class _StarfieldPainter extends CustomPainter {
  final List<_StarData> stars;
  final double progress;
  final Color moonColor;

  _StarfieldPainter(
      {required this.stars, required this.progress, required this.moonColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (final s in stars) {
      final twinkle = 0.3 + 0.7 * ((sin(progress * 2 * pi + s.phase) + 1) / 2);
      paint.color = moonColor.withValues(alpha: twinkle * 0.9);
      canvas.drawCircle(
          Offset(s.x * size.width, s.y * size.height), s.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StarfieldPainter old) =>
      old.progress != progress;
}

// ─────────────────────────────────────────────────────
// Moon painter
// ─────────────────────────────────────────────────────
class _MoonPainter extends CustomPainter {
  final Color color;
  final Color glowColor;
  final double phase;
  final double glowScale;

  _MoonPainter({
    required this.color,
    required this.glowColor,
    required this.phase,
    required this.glowScale,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2 * 0.72;

    // Outer glow halo
    final glowPaint = Paint()
      ..shader = RadialGradient(colors: [
        glowColor.withValues(alpha: 0.55 * glowScale),
        glowColor.withValues(alpha: 0.18),
        Colors.transparent,
      ]).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: r * 1.9));
    canvas.drawCircle(Offset(cx, cy), r * 1.9, glowPaint);

    // ── Moon body ──────────────────────────────────────
    final moonPath = Path()
      ..addOval(Rect.fromCircle(center: Offset(cx, cy), radius: r));

    final Path visiblePath;

    if (phase <= 0.02) {
      // Full moon — draw entire circle
      visiblePath = moonPath;
    } else {
      // Crescent/half: cut ellipse from one side
      // phase 0→1 = shadow grows from right to almost full coverage
      final shadowOffsetX = r * (0.55 + phase * 0.85);
      final shadowRadius = r * (0.88 + phase * 0.12);
      final shadowPath = Path()
        ..addOval(Rect.fromCircle(
            center: Offset(cx + shadowOffsetX, cy), radius: shadowRadius));
      visiblePath =
          Path.combine(PathOperation.difference, moonPath, shadowPath);
    }

    // Moon radial gradient — realistic lit surface
    final moonPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Color.lerp(Colors.white, color, 0.25)!,
          color,
          color.withValues(alpha: 0.88),
        ],
        stops: const [0.0, 0.55, 1.0],
        center: const Alignment(-0.35, -0.35),
      ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: r));

    canvas.drawPath(visiblePath, moonPaint);

    // ── Craters (only visible part) ────────────────────
    // Save and clip to moon shape so craters don't overflow
    canvas.save();
    canvas.clipPath(visiblePath);

    final craterPaint = Paint()
      ..style = PaintingStyle.fill;

    void drawCrater(double dx, double dy, double cr, double alpha) {
      craterPaint.color = color.withValues(alpha: alpha);
      canvas.drawCircle(Offset(cx + dx * r, cy + dy * r), cr * r, craterPaint);
      // Rim highlight
      craterPaint.color = Colors.white.withValues(alpha: alpha * 0.4);
      canvas.drawCircle(
          Offset(cx + dx * r - cr * r * 0.3, cy + dy * r - cr * r * 0.3),
          cr * r * 0.5,
          craterPaint);
    }

    drawCrater(-0.18, -0.28, 0.10, 0.28);
    drawCrater(-0.38, 0.22, 0.07, 0.22);
    drawCrater(0.10, 0.38, 0.06, 0.20);
    drawCrater(0.28, -0.10, 0.05, 0.18);
    drawCrater(-0.05, 0.08, 0.04, 0.16);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _MoonPainter old) =>
      old.glowScale != glowScale || old.phase != phase || old.color != color;
}
