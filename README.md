# confettie_plus 🎊

A **premium, highly customizable** Flutter package featuring 30+ beautiful confetti shapes, physics-based animations, and **stunning natural animated backgrounds** (Sun, Moon, Galaxy) with full developer control.

[![Live Demo](https://img.shields.io/badge/Live_Demo-Click_Here-blue?style=for-the-badge&logo=flutter)](https://ranasheikh64.github.io/confitte-plus/)

---

## ✨ Features

- **🎉 30+ Premium Confetti Shapes** — Stars, Hearts, Moons, Butterflies, Crowns, Sparkles, Lightning, 3D Cubes, Custom Emojis, and many more!
- **🌌 3 Natural Animated Backgrounds** — Sun (with rays & glow), Moon (with phases & starfield), Galaxy (with shooting stars & nebulas).
- **🕹️ Live Interactive Demo** — [Try it out in your browser!](https://ranasheikh64.github.io/confitte-plus/)
- **🚀 Physics-based animation** — gravity, drag, emission force, and fade-out.
- **🔄 Emission Modes** — Burst (explosive) or Continuous (rain/snow effects).
- **🎯 Custom emission source & direction** — Control exact placement and angle.
- **⚡ Performance Optimized** — Built using `CustomPainter`, `RepaintBoundary`, and off-screen culling. Tree-shaking friendly.

---

## 🚀 Quick Start (Confetti)

```dart
import 'package:confettie_plus/confettie_plus.dart';

// 1. Create controller
final controller = ConfettieController(duration: Duration(seconds: 5));

// 2. Wrap your widget
ConfettieWidget(
  controller: controller,
  shapes: [StarShape(), HeartShape(), ButterflyShape(), CrownShape()],
  colors: [Colors.pink, Colors.amber, Colors.cyan, Colors.purple],
  numberOfParticles: 150,
  blastDirection: BlastDirection.explosive,
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

## 🌌 Premium Animated Backgrounds

Use these beautiful, animated widgets as backgrounds for cards, dialogs, or entire screens!

### ☀️ Animated Sun
```dart
AnimatedSunBackground(
  size: 200,
  color: Color(0xFFFFD700),
  rayCount: 12,
  showGlow: true,
  speed: 1.0,
  child: YourWidget(),
)
```

### 🌙 Animated Moon (with Phases)
```dart
AnimatedMoonBackground(
  size: 160,
  moonColor: Color(0xFFFFF8E7),
  moonPhase: MoonPhase.crescent, // full, gibbous, half, crescent, thinCrescent
  starCount: 40,
  speed: 1.0,
  child: YourWidget(),
)
```

### 🌌 Animated Galaxy
```dart
AnimatedGalaxyBackground(
  starCount: 150,
  primaryColor: Color(0xFF7C3AED),
  secondaryColor: Color(0xFF1E3A5F),
  showNebula: true,
  speed: 1.0,
  child: YourWidget(),
)
```

---

## 🎨 Available Confetti Shapes

Over 30 shapes are built-in! You can also easily add your own.

| Shape | Class |
|-------|-------|
| **Premium** | `CrownShape`, `ButterflyShape`, `SparkleShape`, `GemShape`, `CoinShape`, `MusicNoteShape` |
| **Celestial** | `StarShape`, `MoonShape`, `SunShape`, `GalaxyShape`, `CloudShape`, `LightningShape` |
| **Nature** | `FlowerShape`, `LeafShape`, `SnowflakeShape`, `FlameShape`, `TeardropShape` |
| **Classic** | `RectangleShape`, `CircleShape`, `SquareShape`, `TriangleShape`, `DiamondShape`, `HexagonShape`, `PentagonShape` |
| **Ribbons** | `SpiralShape`, `StreamerShape`, `WaveShape`, `BowShape` |
| **Custom Emoji** | `EmojiShape(emoji: '🔥')` |
| **Custom Code** | `CustomShape(builder: ...)` |

---

## 🎯 Advanced Parameters

```dart
ConfettieWidget(
  controller: controller,
  child: myWidget,
  
  shapes: [EmojiShape(emoji: '💸'), CoinShape(), GemShape()],
  colors: [Colors.green, Colors.yellow],
  
  // Sizing & Count
  numberOfParticles: 120,
  minParticleSize: 6.0,
  maxParticleSize: 14.0,

  // Physics
  gravity: 250.0,        // pixels/sec² downward
  blastForce: 350.0,     // initial speed
  drag: 0.05,            // air resistance (0–0.5)

  // Direction & Position
  blastDirection: BlastDirection.up,
  emissionSource: Alignment.bottomCenter,

  // Emission mode
  emissionBehavior: EmissionBehavior.continuous,
  particlesPerSecond: 30,
)
```

---

## 📱 Performance Tips

| Particle Count | Performance | Notes |
|----------------|-------------|-------|
| 50–100 | Excellent | Flawless on all devices |
| 100–250 | Great | Recommended default |
| 250–400 | Good | Works well, physics optimizations kick in |
| 400+ | Moderate | Low-end devices may experience lag |

---

## 📄 License

MIT © confettie_plus contributors
