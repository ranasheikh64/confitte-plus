# confettie_plus 🎊

A **premium, highly customizable** Flutter confetti package with 15+ beautiful particle shapes, realistic physics, and full developer control.

---

## ✨ Features

- **15+ Built-in Shapes** — Rectangle, Circle, Star, Heart, Diamond, Hexagon, Triangle, Snowflake, Spiral, Wave, Leaf, Teardrop, and more
- **Physics-based animation** — gravity, drag, and fade-out
- **Burst or Continuous** emission modes
- **7 blast directions** — up, down, left, right, explosive, upArc, downArc
- **Custom emission source** — any `Alignment` on screen
- **Fully customizable** — colors, particle count, size range, blast force, gravity, drag
- **Custom shapes** — bring your own drawing code via `CustomShape`
- **Tree-shaking friendly** — only the shapes you use end up in your build
- **Performance optimized** — `RepaintBoundary`, `Paint` reuse, off-screen culling

---

## 🚀 Quick Start

```dart
import 'package:confettie_plus/confettie_plus.dart';

// 1. Create controller
final controller = ConfettieController(duration: Duration(seconds: 5));

// 2. Wrap your widget
ConfettieWidget(
  controller: controller,
  shapes: [StarShape(), HeartShape(), DiamondShape()],
  colors: [Colors.pink, Colors.amber, Colors.cyan],
  numberOfParticles: 150,
  child: Scaffold(
    body: Center(
      child: ElevatedButton(
        onPressed: controller.play,
        child: Text('🎉 Celebrate!'),
      ),
    ),
  ),
);

// 3. Always dispose
@override
void dispose() {
  controller.dispose();
  super.dispose();
}
```

---

## 🎨 Available Shapes

| Shape | Class | Description |
|-------|-------|-------------|
| Rectangle | `RectangleShape()` | Classic flat confetti strip |
| Square | `SquareShape()` | Square confetti |
| Rounded Rect | `RoundedRectShape()` | Rectangle with rounded corners |
| Circle | `CircleShape()` | Circular dot |
| Donut | `DonutShape()` | Ring / donut |
| Star ⭐ | `StarShape()` | Configurable star (3–10 points) |
| Snowflake ❄️ | `SnowflakeShape()` | 6-point snowflake |
| Heart ❤️ | `HeartShape()` | Heart shape |
| Bow 🎀 | `BowShape()` | Ribbon bow |
| Moon 🌙 | `MoonShape()` | Crescent moon |
| Flower 🌸 | `FlowerShape()` | Multi-petal flower |
| Triangle | `TriangleShape()` | Equilateral triangle |
| Arrow | `ArrowShape()` | Upward arrow |
| Lightning ⚡ | `LightningShape()` | Lightning bolt |
| Diamond 💎 | `DiamondShape()` | Rhombus |
| Hexagon | `HexagonShape()` | Hexagonal shape |
| Pentagon | `PentagonShape()` | Pentagon |
| Spiral 🎊 | `SpiralShape()` | Curled spiral ribbon |
| Streamer | `StreamerShape()` | Curly streamer |
| Cross | `CrossShape()` | Plus sign |
| X | `XShape()` | X shape |
| Wave | `WaveShape()` | Wavy ribbon |
| Teardrop | `TeardropShape()` | Teardrop |
| Leaf 🍃 | `LeafShape()` | Leaf with midrib |
| Custom ✨ | `CustomShape(builder: ...)` | Your own drawing code |

---

## ⚙️ All Parameters

```dart
ConfettieWidget(
  controller: controller,          // required
  child: myWidget,                 // required

  // Shapes — only what you include will appear
  shapes: [StarShape(), HeartShape()],

  // Colors
  colors: [Colors.pink, Colors.amber],

  // Particle settings
  numberOfParticles: 120,
  minParticleSize: 6.0,
  maxParticleSize: 14.0,

  // Physics
  gravity: 250.0,        // pixels/sec² downward
  blastForce: 350.0,     // initial speed
  drag: 0.05,            // air resistance (0–0.5)

  // Direction
  blastDirection: BlastDirection.explosive,
  emissionSource: Alignment.topCenter,

  // Emission mode
  emissionBehavior: EmissionBehavior.burst,
  particlesPerSecond: 30,  // for continuous mode
)
```

---

## 🎯 Usage Examples

### Stars from bottom
```dart
ConfettieWidget(
  controller: controller,
  shapes: [StarShape(), StarShape(points: 8)],
  blastDirection: BlastDirection.upArc,
  emissionSource: Alignment.bottomCenter,
  gravity: 200,
  blastForce: 400,
  child: myChild,
)
```

### Continuous rain effect
```dart
ConfettieWidget(
  controller: controller,
  shapes: [TeardropShape(), CircleShape()],
  emissionBehavior: EmissionBehavior.continuous,
  particlesPerSecond: 25,
  blastDirection: BlastDirection.down,
  gravity: 400,
  child: myChild,
)
```

### Custom shape
```dart
ConfettieWidget(
  controller: controller,
  shapes: [
    CustomShape(
      builder: (canvas, paint, size) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset.zero, width: size, height: size),
            Radius.circular(4),
          ),
          paint,
        );
      },
    ),
  ],
  child: myChild,
)
```

---

## 📱 Performance Tips

| Particle Count | Performance | Notes |
|----------------|-------------|-------|
| 50–100 | Excellent | All devices |
| 100–200 | Great | Recommended default |
| 200–350 | Good | RepaintBoundary helps |
| 350+ | Moderate | Low-end devices may lag |

---

## 📄 License

MIT © confettie_plus contributors
# confitte-plus
