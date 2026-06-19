/// Defines the direction in which confetti particles are blasted.
enum BlastDirection {
  /// Particles explode outward in all directions (like a firework).
  explosive,

  /// Particles shoot upward.
  up,

  /// Particles shoot downward.
  down,

  /// Particles shoot to the left.
  left,

  /// Particles shoot to the right.
  right,

  /// Particles fan out in a 180° arc upward.
  upArc,

  /// Particles fan out in a 180° arc downward.
  downArc,
}
