/// Confettie Plus — A premium, highly customizable Flutter confetti package.
///
/// ## Quick Start
/// ```dart
/// final controller = ConfettieController(duration: Duration(seconds: 5));
///
/// ConfettieWidget(
///   controller: controller,
///   shapes: [StarShape(), HeartShape(), CircleShape()],
///   colors: [Colors.pink, Colors.amber, Colors.cyan],
///   numberOfParticles: 150,
///   child: YourWidget(),
/// );
///
/// // Trigger confetti
/// controller.play();
/// ```
library;

export 'src/confettie_widget.dart';
export 'src/confettie_controller.dart';
export 'src/shapes/confettie_shape.dart';
export 'src/shapes/rectangle_shape.dart';
export 'src/shapes/circle_shape.dart';
export 'src/shapes/star_shape.dart';
export 'src/shapes/heart_shape.dart';
export 'src/shapes/triangle_shape.dart';
export 'src/shapes/diamond_shape.dart';
export 'src/shapes/spiral_shape.dart';
export 'src/shapes/cross_shape.dart';
export 'src/shapes/teardrop_shape.dart';
export 'src/shapes/wave_shape.dart';
export 'src/shapes/custom_shape.dart';
export 'src/shapes/premium_shapes.dart';
export 'src/models/blast_direction.dart';
export 'src/models/emission_behavior.dart';

// ── Animated Backgrounds ──────────────────────────────
export 'src/backgrounds/animated_sun_background.dart';
export 'src/backgrounds/animated_moon_background.dart';
export 'src/backgrounds/animated_galaxy_background.dart';
