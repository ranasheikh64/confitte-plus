import 'dart:math';
import 'package:flutter/material.dart';
import '../shapes/confettie_shape.dart';
import '../models/blast_direction.dart';

/// Represents a single confetti particle with physics state.
class ConfettieParticle {
  double x;
  double y;
  double velocityX;
  double velocityY;
  double rotation;
  double rotationSpeed;
  Color color;
  double size;
  double opacity;
  ConfettieShape shape;

  ConfettieParticle({
    required this.x,
    required this.y,
    required this.velocityX,
    required this.velocityY,
    required this.rotation,
    required this.rotationSpeed,
    required this.color,
    required this.size,
    required this.shape,
    this.opacity = 1.0,
  });

  factory ConfettieParticle.random({
    required double startX,
    required double startY,
    required List<Color> colors,
    required List<ConfettieShape> shapes,
    required Random random,
    required double blastForce,
    required double minSize,
    required double maxSize,
    required BlastDirection blastDirection,
  }) {
    final angle = _angleForDirection(blastDirection, random);
    final speed = blastForce * (0.4 + random.nextDouble() * 0.6);

    return ConfettieParticle(
      x: startX,
      y: startY,
      velocityX: cos(angle) * speed,
      velocityY: sin(angle) * speed,
      rotation: random.nextDouble() * 2 * pi,
      rotationSpeed: (random.nextDouble() - 0.5) * 0.25,
      color: colors[random.nextInt(colors.length)],
      size: minSize + random.nextDouble() * (maxSize - minSize),
      shape: shapes[random.nextInt(shapes.length)],
      opacity: 1.0,
    );
  }

  static double _angleForDirection(BlastDirection dir, Random random) {
    switch (dir) {
      case BlastDirection.explosive:
        return random.nextDouble() * 2 * pi;
      case BlastDirection.up:
        return -pi / 2 + (random.nextDouble() - 0.5) * pi * 0.5;
      case BlastDirection.down:
        return pi / 2 + (random.nextDouble() - 0.5) * pi * 0.5;
      case BlastDirection.left:
        return pi + (random.nextDouble() - 0.5) * pi * 0.5;
      case BlastDirection.right:
        return (random.nextDouble() - 0.5) * pi * 0.5;
      case BlastDirection.upArc:
        return -pi + random.nextDouble() * pi; // -180° to 0°
      case BlastDirection.downArc:
        return random.nextDouble() * pi; // 0° to 180°
    }
  }

  /// Update particle physics for one frame.
  void update({
    required double gravity,
    required double drag,
    required double dt,
    required double screenHeight,
  }) {
    velocityX *= (1 - drag * dt);
    velocityY *= (1 - drag * dt);
    velocityY += gravity * dt;

    x += velocityX * dt;
    y += velocityY * dt;
    rotation += rotationSpeed;

    // Fade out as particle approaches bottom of screen
    if (y > screenHeight * 0.7) {
      opacity = ((screenHeight - y) / (screenHeight * 0.3)).clamp(0.0, 1.0);
    }
  }

  bool isOffScreen(double screenHeight) => y > screenHeight + 60;
}
