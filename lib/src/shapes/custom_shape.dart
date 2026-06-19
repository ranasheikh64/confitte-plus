import 'package:flutter/material.dart';
import 'confettie_shape.dart';

/// Allows you to define any arbitrary shape using a builder callback.
///
/// ```dart
/// CustomShape(
///   builder: (canvas, paint, size) {
///     canvas.drawRRect(
///       RRect.fromRectAndRadius(
///         Rect.fromCenter(center: Offset.zero, width: size, height: size),
///         Radius.circular(4),
///       ),
///       paint,
///     );
///   },
/// )
/// ```
class CustomShape extends ConfettieShape {
  /// Builder that receives [canvas], [paint], and [size] to draw any shape.
  final void Function(Canvas canvas, Paint paint, double size) builder;

  const CustomShape({required this.builder});

  @override
  void draw(Canvas canvas, Paint paint, double size) {
    builder(canvas, paint, size);
  }
}
