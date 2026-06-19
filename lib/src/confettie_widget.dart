import 'dart:math';
import 'package:flutter/material.dart';

import 'confettie_controller.dart';
import 'confettie_painter.dart';
import 'models/confettie_particle.dart';
import 'models/blast_direction.dart';
import 'models/emission_behavior.dart';
import 'shapes/confettie_shape.dart';
import 'shapes/rectangle_shape.dart';
import 'shapes/circle_shape.dart';
import 'shapes/star_shape.dart';

/// A widget that overlays beautiful confetti particles over its [child].
///
/// Control playback via [ConfettieController].
///
/// ## Example
/// ```dart
/// final controller = ConfettieController(duration: Duration(seconds: 5));
///
/// ConfettieWidget(
///   controller: controller,
///   shapes: [StarShape(), HeartShape(), CircleShape()],
///   colors: [Colors.pink, Colors.amber, Colors.cyan],
///   numberOfParticles: 150,
///   gravity: 300,
///   blastDirection: BlastDirection.upArc,
///   emissionSource: Alignment.bottomCenter,
///   child: Scaffold(
///     body: Center(
///       child: ElevatedButton(
///         onPressed: controller.play,
///         child: Text('🎉 Celebrate!'),
///       ),
///     ),
///   ),
/// );
/// ```
class ConfettieWidget extends StatefulWidget {
  /// Required controller to trigger play/stop.
  final ConfettieController controller;

  /// The widget displayed beneath the confetti layer.
  final Widget child;

  /// List of confetti shapes to use. Only shapes you include will appear.
  ///
  /// Defaults to [RectangleShape], [CircleShape], [StarShape].
  ///
  /// ```dart
  /// shapes: [StarShape(), HeartShape(), DiamondShape()],
  /// ```
  final List<ConfettieShape> shapes;

  /// Colors to randomly assign to particles.
  ///
  /// Defaults to a vibrant rainbow palette.
  final List<Color> colors;

  /// Total number of particles per burst.
  ///
  /// Recommended: 80–200. Above 300 may lag on low-end devices.
  final int numberOfParticles;

  /// Downward acceleration (pixels/sec²). Higher = falls faster.
  ///
  /// Default: 250.
  final double gravity;

  /// Air resistance. 0 = no drag, 1 = instant stop. Keep between 0–0.5.
  ///
  /// Default: 0.05.
  final double drag;

  /// Initial burst force in pixels/sec. Controls how far particles spread.
  ///
  /// Default: 350.
  final double blastForce;

  /// Direction particles are blasted in.
  ///
  /// Default: [BlastDirection.explosive].
  final BlastDirection blastDirection;

  /// Where on the screen particles originate from.
  ///
  /// Default: [Alignment.topCenter].
  final Alignment emissionSource;

  /// Smallest particle size in logical pixels.
  final double minParticleSize;

  /// Largest particle size in logical pixels.
  final double maxParticleSize;

  /// Whether to burst all at once or emit continuously.
  final EmissionBehavior emissionBehavior;

  /// For [EmissionBehavior.continuous], how many particles spawn per second.
  final int particlesPerSecond;

  const ConfettieWidget({
    super.key,
    required this.controller,
    required this.child,
    this.shapes = const [RectangleShape(), CircleShape(), StarShape()],
    this.colors = const [
      Color(0xFFFF4081), // pink
      Color(0xFF40C4FF), // light blue
      Color(0xFFFFD740), // amber
      Color(0xFF69F0AE), // green
      Color(0xFFEA80FC), // purple
      Color(0xFFFF6E40), // deep orange
      Color(0xFFCCFF90), // light green
      Color(0xFF80D8FF), // cyan
    ],
    this.numberOfParticles = 120,
    this.gravity = 250.0,
    this.drag = 0.05,
    this.blastForce = 350.0,
    this.blastDirection = BlastDirection.explosive,
    this.emissionSource = Alignment.topCenter,
    this.minParticleSize = 6.0,
    this.maxParticleSize = 14.0,
    this.emissionBehavior = EmissionBehavior.burst,
    this.particlesPerSecond = 30,
  });

  @override
  State<ConfettieWidget> createState() => _ConfettieWidgetState();
}

class _ConfettieWidgetState extends State<ConfettieWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ticker;
  final List<ConfettieParticle> _particles = [];
  final Random _random = Random();

  Size? _cachedSize;
  double _continuousAccumulator = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerChanged);

    _ticker = AnimationController(
      vsync: this,
      // Long duration — we manage animation manually
      duration: const Duration(hours: 1),
    )..addListener(_onTick);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cachedSize = MediaQuery.of(context).size;
  }

  void _onControllerChanged() {
    if (widget.controller.isPlaying) {
      _startConfetti();
    } else {
      _stopConfetti();
    }
  }

  void _startConfetti() {
    final size = _cachedSize ?? MediaQuery.of(context).size;
    final origin = widget.emissionSource.withinRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );

    if (widget.emissionBehavior == EmissionBehavior.burst) {
      _particles.clear();
      for (int i = 0; i < widget.numberOfParticles; i++) {
        _particles.add(_createParticle(origin));
      }
    }

    _continuousAccumulator = 0;
    _ticker.repeat();

    // Auto-stop after controller duration
    Future.delayed(widget.controller.duration, () {
      if (mounted && widget.controller.isPlaying) {
        widget.controller.stop();
      }
    });
  }

  void _stopConfetti() {
    _ticker.stop();
    setState(() => _particles.clear());
  }

  ConfettieParticle _createParticle(Offset origin) {
    return ConfettieParticle.random(
      startX: origin.dx,
      startY: origin.dy,
      colors: widget.colors,
      shapes: widget.shapes,
      random: _random,
      blastForce: widget.blastForce,
      minSize: widget.minParticleSize,
      maxSize: widget.maxParticleSize,
      blastDirection: widget.blastDirection,
    );
  }

  void _onTick() {
    final size = _cachedSize ?? MediaQuery.of(context).size;
    const dt = 1 / 60;

    // Continuous emission — spawn new particles each frame
    if (widget.emissionBehavior == EmissionBehavior.continuous &&
        widget.controller.isPlaying) {
      _continuousAccumulator += widget.particlesPerSecond * dt;
      final toSpawn = _continuousAccumulator.floor();
      if (toSpawn > 0) {
        _continuousAccumulator -= toSpawn;
        final origin = widget.emissionSource.withinRect(
          Rect.fromLTWH(0, 0, size.width, size.height),
        );
        for (int i = 0; i < toSpawn; i++) {
          _particles.add(_createParticle(origin));
        }
      }
    }

    // Update physics for all particles
    for (final p in _particles) {
      p.update(
        gravity: widget.gravity,
        drag: widget.drag,
        dt: dt,
        screenHeight: size.height,
      );
    }

    // Remove particles that are off-screen or fully transparent
    _particles.removeWhere(
        (p) => p.isOffScreen(size.height) || p.opacity <= 0);

    setState(() {});
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_particles.isNotEmpty)
          Positioned.fill(
            child: IgnorePointer(
              child: RepaintBoundary(
                child: CustomPaint(
                  painter: ConfettiePainter(particles: List.of(_particles)),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
