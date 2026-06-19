import 'package:flutter/material.dart';

/// Abstract base class for all confetti particle shapes.
///
/// Extend this class to create your own custom confetti shapes.
///
/// ```dart
/// class MyShape extends ConfettieShape {
///   @override
///   void draw(Canvas canvas, Paint paint, double size) {
///     canvas.drawCircle(Offset.zero, size / 2, paint);
///   }
/// }
/// ```
abstract class ConfettieShape {
  const ConfettieShape();

  /// Draw the shape centered at [Offset.zero] on [canvas].
  ///
  /// The canvas is already translated and rotated. [size] is the
  /// diameter/width of the particle.
  void draw(Canvas canvas, Paint paint, double size);

  /// Optional secondary color for gradient effects.
  Color? get secondaryColor => null;
}
