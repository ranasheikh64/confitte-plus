import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confettie_plus/confettie_plus.dart';

class ConfettiePreset {
  final String name;
  final String emoji;
  final List<ConfettieShape> shapes;
  final List<Color> colors;
  final int numberOfParticles;
  final double gravity;
  final double blastForce;
  final double drag;
  final BlastDirection blastDirection;
  final Alignment emissionSource;
  final EmissionBehavior emissionBehavior;
  final int particlesPerSecond;
  final Color cardA;
  final Color cardB;
  final String description;

  const ConfettiePreset({
    required this.name,
    required this.emoji,
    required this.shapes,
    required this.colors,
    required this.cardA,
    required this.cardB,
    required this.description,
    this.numberOfParticles = 120,
    this.gravity = 250,
    this.blastForce = 350,
    this.drag = 0.05,
    this.blastDirection = BlastDirection.explosive,
    this.emissionSource = Alignment.topCenter,
    this.emissionBehavior = EmissionBehavior.burst,
    this.particlesPerSecond = 30,
  });
}

void _drawCustomStar(Canvas canvas, Paint paint, double size) {
  const pts = 6;
  final r = size / 2;
  final path = Path();
  for (int i = 0; i < pts * 2; i++) {
    final radius = i.isEven ? r : r * 0.45;
    final angle = (i * pi) / pts - pi / 2;
    final point = Offset(radius * cos(angle), radius * sin(angle));
    if (i == 0) {
      path.moveTo(point.dx, point.dy);
    } else {
      path.lineTo(point.dx, point.dy);
    }
  }
  path.close();
  canvas.drawPath(path, paint);
}

final List<ConfettiePreset> allPresets = [
  // ── Original 12 ──────────────────────────────────────
  ConfettiePreset(
    name: 'Classic',
    emoji: '🎊',
    description: 'Timeless confetti strips',
    shapes: const [RectangleShape(), SquareShape(), RoundedRectShape()],
    colors: const [Color(0xFFFF4081), Color(0xFF40C4FF), Color(0xFFFFD740), Color(0xFF69F0AE), Color(0xFFEA80FC), Color(0xFFFF6E40)],
    cardA: Color(0xFFFF4081), cardB: Color(0xFFFF6E40),
    numberOfParticles: 160, blastDirection: BlastDirection.explosive, emissionSource: Alignment.center,
  ),
  ConfettiePreset(
    name: 'Stars',
    emoji: '⭐',
    description: '5 & 8-pointed star shower',
    shapes: const [StarShape(), StarShape(points: 6), StarShape(points: 8, innerRadiusRatio: 0.5)],
    colors: const [Color(0xFFFFD700), Color(0xFFFFA500), Color(0xFFFF8C00), Color(0xFFFFEC5C), Color(0xFFFFF176)],
    cardA: Color(0xFFFFB300), cardB: Color(0xFFFF6F00),
    numberOfParticles: 130, blastDirection: BlastDirection.upArc, emissionSource: Alignment.bottomCenter, gravity: 200, blastForce: 400,
  ),
  ConfettiePreset(
    name: 'Hearts',
    emoji: '❤️',
    description: 'Romantic hearts & circles',
    shapes: const [HeartShape(), CircleShape()],
    colors: const [Color(0xFFFF1744), Color(0xFFFF4569), Color(0xFFFF80AB), Color(0xFFFF8A80), Color(0xFFF48FB1)],
    cardA: Color(0xFFE91E63), cardB: Color(0xFF880E4F),
    numberOfParticles: 100, blastDirection: BlastDirection.upArc, emissionSource: Alignment.bottomCenter, gravity: 180, blastForce: 380,
  ),
  ConfettiePreset(
    name: 'Diamonds',
    emoji: '💎',
    description: 'Precious gems & polygons',
    shapes: const [DiamondShape(), HexagonShape(), PentagonShape()],
    colors: const [Color(0xFF00E5FF), Color(0xFF40C4FF), Color(0xFF00B0FF), Color(0xFF80D8FF), Color(0xFFB3E5FC)],
    cardA: Color(0xFF0288D1), cardB: Color(0xFF006064),
    numberOfParticles: 120, blastDirection: BlastDirection.explosive, emissionSource: Alignment.center, gravity: 280, blastForce: 320,
  ),
  ConfettiePreset(
    name: 'Ribbons',
    emoji: '🎀',
    description: 'Swirling streamers & spirals',
    shapes: const [StreamerShape(), SpiralShape(), WaveShape()],
    colors: const [Color(0xFFE040FB), Color(0xFF7C4DFF), Color(0xFF40C4FF), Color(0xFFFF4081), Color(0xFF69F0AE)],
    cardA: Color(0xFF7B1FA2), cardB: Color(0xFF311B92),
    numberOfParticles: 100, gravity: 200, blastForce: 280, drag: 0.08, blastDirection: BlastDirection.upArc, emissionSource: Alignment.bottomCenter,
  ),
  ConfettiePreset(
    name: 'Nature',
    emoji: '🍃',
    description: 'Leaves & blossoms falling',
    shapes: const [LeafShape(), FlowerShape(), TeardropShape()],
    colors: const [Color(0xFF00C853), Color(0xFF64DD17), Color(0xFF76FF03), Color(0xFFCCFF90), Color(0xFFB9F6CA)],
    cardA: Color(0xFF2E7D32), cardB: Color(0xFF1B5E20),
    numberOfParticles: 100, gravity: 150, blastForce: 300, drag: 0.06, blastDirection: BlastDirection.upArc, emissionSource: Alignment.bottomCenter,
  ),
  ConfettiePreset(
    name: 'Snowflakes',
    emoji: '❄️',
    description: 'Gentle winter snowfall',
    shapes: const [SnowflakeShape(), CircleShape(), DiamondShape()],
    colors: const [Color(0xFFE3F2FD), Color(0xFFBBDEFB), Color(0xFF90CAF9), Color(0xFFE1F5FE), Color(0xFFB3E5FC)],
    cardA: Color(0xFF1565C0), cardB: Color(0xFF0D47A1),
    numberOfParticles: 120, gravity: 100, blastForce: 250, drag: 0.1, blastDirection: BlastDirection.upArc,
  ),
  ConfettiePreset(
    name: 'Galaxy',
    emoji: '🌌',
    description: 'Deep space particles',
    shapes: const [StarShape(), DonutShape(), CrossShape(), DiamondShape()],
    colors: const [Color(0xFFAA00FF), Color(0xFF6200EA), Color(0xFF3D5AFE), Color(0xFF00E5FF), Color(0xFF00BFA5)],
    cardA: Color(0xFF4A148C), cardB: Color(0xFF0D0D2B),
    numberOfParticles: 180, gravity: 200, blastForce: 420, blastDirection: BlastDirection.explosive, emissionSource: Alignment.center,
  ),
  ConfettiePreset(
    name: 'Lightning',
    emoji: '⚡',
    description: 'Electric bolts & arrows',
    shapes: const [LightningShape(), ArrowShape(), TriangleShape()],
    colors: const [Color(0xFFFFFF00), Color(0xFFFFFF8D), Color(0xFFFFF176), Color(0xFFFFEE58), Color(0xFFFFCA28)],
    cardA: Color(0xFFF57F17), cardB: Color(0xFF212121),
    numberOfParticles: 130, gravity: 350, blastForce: 500, blastDirection: BlastDirection.explosive, emissionSource: Alignment.center,
  ),
  ConfettiePreset(
    name: 'Rain',
    emoji: '🌧️',
    description: 'Continuous rainfall',
    shapes: const [TeardropShape(), CircleShape()],
    colors: const [Color(0xFF29B6F6), Color(0xFF4FC3F7), Color(0xFF81D4FA), Color(0xFF0288D1), Color(0xFFB3E5FC)],
    cardA: Color(0xFF01579B), cardB: Color(0xFF263238),
    numberOfParticles: 30, gravity: 400, blastForce: 150, blastDirection: BlastDirection.down,
    emissionBehavior: EmissionBehavior.continuous, particlesPerSecond: 25,
  ),
  ConfettiePreset(
    name: 'Fireworks',
    emoji: '🎆',
    description: 'Grand finale explosion',
    shapes: const [StarShape(), CircleShape(), DiamondShape()],
    colors: const [Color(0xFFFF1744), Color(0xFFFFD600), Color(0xFF00E5FF), Color(0xFF00C853), Color(0xFFAA00FF), Color(0xFFFF6D00)],
    cardA: Color(0xFF880E4F), cardB: Color(0xFF0D0D2D),
    numberOfParticles: 200, gravity: 220, blastForce: 500, drag: 0.03, blastDirection: BlastDirection.explosive, emissionSource: Alignment.center,
  ),
  ConfettiePreset(
    name: 'Custom ✦',
    emoji: '✨',
    description: 'Your own 6-point star',
    shapes: [CustomShape(builder: _drawCustomStar)],
    colors: const [Color(0xFFFFD700), Color(0xFFFF69B4), Color(0xFF00CED1)],
    cardA: Color(0xFF6A1B9A), cardB: Color(0xFF4A148C),
    numberOfParticles: 120, blastDirection: BlastDirection.explosive, emissionSource: Alignment.center,
  ),

  // ── 18 New Premium Presets ────────────────────────────
  ConfettiePreset(
    name: 'Sparkle',
    emoji: '✦',
    description: '4-point glitter burst',
    shapes: const [SparkleShape(), SparkleShape(points: 6), CircleShape()],
    colors: const [Color(0xFFFFF9C4), Color(0xFFFFEB3B), Color(0xFFFFD54F), Color(0xFFFFCC02), Color(0xFFFFA000)],
    cardA: Color(0xFFF9A825), cardB: Color(0xFFE65100),
    numberOfParticles: 140, blastDirection: BlastDirection.explosive, emissionSource: Alignment.center, gravity: 230, blastForce: 400,
  ),
  ConfettiePreset(
    name: 'Comets',
    emoji: '🌠',
    description: 'Shooting stars streak by',
    shapes: const [CometShape(), StarShape()],
    colors: const [Color(0xFFE0F7FA), Color(0xFFB2EBF2), Color(0xFF80DEEA), Color(0xFF4DD0E1), Color(0xFF00BCD4)],
    cardA: Color(0xFF006064), cardB: Color(0xFF0D1B2A),
    numberOfParticles: 80, gravity: 180, blastForce: 450, drag: 0.04,
    blastDirection: BlastDirection.explosive, emissionSource: Alignment.center,
  ),
  ConfettiePreset(
    name: 'Royal',
    emoji: '👑',
    description: 'Crowns fit for a king',
    shapes: const [CrownShape(), DiamondShape(), StarShape()],
    colors: const [Color(0xFFFFD700), Color(0xFFFFC107), Color(0xFFFF8F00), Color(0xFFFFE082), Color(0xFFBFA000)],
    cardA: Color(0xFF7B1F00), cardB: Color(0xFF3E1000),
    numberOfParticles: 110, gravity: 260, blastForce: 370, blastDirection: BlastDirection.upArc, emissionSource: Alignment.bottomCenter,
  ),
  ConfettiePreset(
    name: 'Butterflies',
    emoji: '🦋',
    description: 'Elegant wings flutter by',
    shapes: const [ButterflyShape(), FlowerShape(), HeartShape()],
    colors: const [Color(0xFFCE93D8), Color(0xFFBA68C8), Color(0xFF9C27B0), Color(0xFF7B1FA2), Color(0xFFE1BEE7)],
    cardA: Color(0xFF6A1B9A), cardB: Color(0xFF1A237E),
    numberOfParticles: 80, gravity: 140, blastForce: 280, drag: 0.07,
    blastDirection: BlastDirection.upArc, emissionSource: Alignment.bottomCenter,
  ),
  ConfettiePreset(
    name: 'Music',
    emoji: '🎵',
    description: 'Notes fill the air',
    shapes: const [MusicNoteShape(), CircleShape(), RoundedRectShape()],
    colors: const [Color(0xFFF48FB1), Color(0xFFF06292), Color(0xFFEC407A), Color(0xFFE91E63), Color(0xFFC2185B)],
    cardA: Color(0xFF880E4F), cardB: Color(0xFF311B92),
    numberOfParticles: 100, gravity: 200, blastForce: 320, drag: 0.06,
    blastDirection: BlastDirection.explosive, emissionSource: Alignment.center,
  ),
  ConfettiePreset(
    name: 'Balloons',
    emoji: '🎈',
    description: 'Party balloons floating up',
    shapes: const [BalloonShape(), CircleShape()],
    colors: const [Color(0xFFFF6090), Color(0xFF6EC6FF), Color(0xFFFFF176), Color(0xFFA5D6A7), Color(0xFFCE93D8)],
    cardA: Color(0xFFE91E63), cardB: Color(0xFF1565C0),
    numberOfParticles: 60, gravity: -80, blastForce: 200, drag: 0.12,
    blastDirection: BlastDirection.upArc, emissionSource: Alignment.bottomCenter,
  ),
  ConfettiePreset(
    name: 'Flames',
    emoji: '🔥',
    description: 'Fire blazing upward',
    shapes: const [FlameShape(), TriangleShape(), LightningShape()],
    colors: const [Color(0xFFFF1744), Color(0xFFFF6D00), Color(0xFFFFD600), Color(0xFFFF3D00), Color(0xFFBF360C)],
    cardA: Color(0xFFBF360C), cardB: Color(0xFF1A0A00),
    numberOfParticles: 120, gravity: 160, blastForce: 380, drag: 0.05,
    blastDirection: BlastDirection.upArc, emissionSource: Alignment.bottomCenter,
  ),
  ConfettiePreset(
    name: 'Gems',
    emoji: '💠',
    description: 'Faceted crystals scatter',
    shapes: const [GemShape(), CrystalShard(), DiamondShape()],
    colors: const [Color(0xFF00E5FF), Color(0xFF40C4FF), Color(0xFFB388FF), Color(0xFF69F0AE), Color(0xFFFFD740)],
    cardA: Color(0xFF00838F), cardB: Color(0xFF1A0533),
    numberOfParticles: 130, gravity: 290, blastForce: 360, blastDirection: BlastDirection.explosive, emissionSource: Alignment.center,
  ),
  ConfettiePreset(
    name: 'Lucky',
    emoji: '🍀',
    description: 'Four-leaf clovers & luck',
    shapes: const [CloverShape(), HeartShape(), CircleShape()],
    colors: const [Color(0xFF00C853), Color(0xFF69F0AE), Color(0xFF76FF03), Color(0xFFCCFF90), Color(0xFF1B5E20)],
    cardA: Color(0xFF2E7D32), cardB: Color(0xFF003300),
    numberOfParticles: 100, gravity: 200, blastForce: 330, blastDirection: BlastDirection.upArc, emissionSource: Alignment.bottomCenter,
  ),
  ConfettiePreset(
    name: 'Sunshine',
    emoji: '☀️',
    description: 'Suns & rays of light',
    shapes: const [SunShape(), StarShape(), CircleShape()],
    colors: const [Color(0xFFFFFF00), Color(0xFFFFEA00), Color(0xFFFFD600), Color(0xFFFFC400), Color(0xFFFFAB00)],
    cardA: Color(0xFFF9A825), cardB: Color(0xFF7B3900),
    numberOfParticles: 110, gravity: 210, blastForce: 350, blastDirection: BlastDirection.explosive, emissionSource: Alignment.center,
  ),
  ConfettiePreset(
    name: 'Cosmos',
    emoji: '🪐',
    description: 'Planets orbit the screen',
    shapes: const [PlanetShape(), StarShape(), CircleShape(), DonutShape()],
    colors: const [Color(0xFF7986CB), Color(0xFF5C6BC0), Color(0xFF3949AB), Color(0xFF00BCD4), Color(0xFFE040FB)],
    cardA: Color(0xFF1A237E), cardB: Color(0xFF000033),
    numberOfParticles: 90, gravity: 150, blastForce: 380, drag: 0.04, blastDirection: BlastDirection.explosive, emissionSource: Alignment.center,
  ),
  ConfettiePreset(
    name: 'Burst',
    emoji: '💥',
    description: 'Explosive spike bursts',
    shapes: const [BurstShape(), BurstShape(spikes: 8), SparkleShape()],
    colors: const [Color(0xFFFF6D00), Color(0xFFFF3D00), Color(0xFFFFD600), Color(0xFFFF1744), Color(0xFFFFAB40)],
    cardA: Color(0xFFBF360C), cardB: Color(0xFF212121),
    numberOfParticles: 140, gravity: 300, blastForce: 500, blastDirection: BlastDirection.explosive, emissionSource: Alignment.center,
  ),
  ConfettiePreset(
    name: 'Crinkle',
    emoji: '🎉',
    description: 'Zigzag ribbon madness',
    shapes: const [CrinkleShape(), WaveShape(), StreamerShape()],
    colors: const [Color(0xFFFF4081), Color(0xFF40C4FF), Color(0xFFFFD740), Color(0xFF69F0AE), Color(0xFFEA80FC)],
    cardA: Color(0xFFAD1457), cardB: Color(0xFF4527A0),
    numberOfParticles: 120, gravity: 220, blastForce: 300, drag: 0.07, blastDirection: BlastDirection.upArc, emissionSource: Alignment.bottomCenter,
  ),
  ConfettiePreset(
    name: 'Cloud',
    emoji: '☁️',
    description: 'Fluffy clouds drift down',
    shapes: const [CloudShape(), CircleShape(), DonutShape()],
    colors: const [Color(0xFFECEFF1), Color(0xFFCFD8DC), Color(0xFFB0BEC5), Color(0xFF90A4AE), Color(0xFFE1F5FE)],
    cardA: Color(0xFF546E7A), cardB: Color(0xFF1C313A),
    numberOfParticles: 70, gravity: 100, blastForce: 200, drag: 0.1, blastDirection: BlastDirection.down,
    emissionBehavior: EmissionBehavior.continuous, particlesPerSecond: 15,
  ),
  ConfettiePreset(
    name: 'Paper Planes',
    emoji: '✈️',
    description: 'Fleet of paper planes',
    shapes: const [PaperPlaneShape(), TriangleShape(), ArrowShape()],
    colors: const [Color(0xFFE3F2FD), Color(0xFF90CAF9), Color(0xFF42A5F5), Color(0xFF1E88E5), Color(0xFF1565C0)],
    cardA: Color(0xFF1565C0), cardB: Color(0xFF003459),
    numberOfParticles: 90, gravity: 180, blastForce: 370, blastDirection: BlastDirection.explosive, emissionSource: Alignment.center,
  ),
  ConfettiePreset(
    name: 'Peace',
    emoji: '☮️',
    description: 'Peace & love in the air',
    shapes: const [PeaceShape(), HeartShape(), FlowerShape()],
    colors: const [Color(0xFFA5D6A7), Color(0xFF81C784), Color(0xFF66BB6A), Color(0xFF43A047), Color(0xFF388E3C)],
    cardA: Color(0xFF1B5E20), cardB: Color(0xFF004D00),
    numberOfParticles: 100, gravity: 160, blastForce: 310, blastDirection: BlastDirection.upArc, emissionSource: Alignment.bottomCenter,
  ),
  ConfettiePreset(
    name: 'Rose Gold',
    emoji: '🌹',
    description: 'Luxurious rose gold shimmer',
    shapes: const [CircleShape(), DiamondShape(), SparkleShape(), RoundedRectShape()],
    colors: const [Color(0xFFB76E79), Color(0xFFE8A0A0), Color(0xFFC9956C), Color(0xFFFFD1D1), Color(0xFFD4956A)],
    cardA: Color(0xFF9C4040), cardB: Color(0xFF5D1F1F),
    numberOfParticles: 140, gravity: 240, blastForce: 360, blastDirection: BlastDirection.explosive, emissionSource: Alignment.center,
  ),
  ConfettiePreset(
    name: 'Neon',
    emoji: '🌈',
    description: 'Electric neon overload',
    shapes: const [StarShape(), BurstShape(), SparkleShape(), CircleShape()],
    colors: const [Color(0xFF00FF41), Color(0xFF00F0FF), Color(0xFFFF00FF), Color(0xFFFFFF00), Color(0xFFFF003C)],
    cardA: Color(0xFF00B300), cardB: Color(0xFF1A0033),
    numberOfParticles: 160, gravity: 260, blastForce: 430, blastDirection: BlastDirection.explosive, emissionSource: Alignment.center,
  ),
  ConfettiePreset(
    name: 'Aurora',
    emoji: '🌌',
    description: 'Northern lights cascade',
    shapes: const [WaveShape(), StreamerShape(), SpiralShape(), CrinkleShape()],
    colors: const [Color(0xFF00FFA3), Color(0xFF00BFFF), Color(0xFF9B59B6), Color(0xFF00FF7F), Color(0xFF1E90FF)],
    cardA: Color(0xFF003D33), cardB: Color(0xFF0D0D3B),
    numberOfParticles: 80, gravity: 120, blastForce: 260, drag: 0.09,
    blastDirection: BlastDirection.down, emissionBehavior: EmissionBehavior.continuous, particlesPerSecond: 20,
  ),
];
