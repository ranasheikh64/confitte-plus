import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confettie_plus/confettie_plus.dart';
import 'presets.dart';

// ─────────────────────────────────────────────────────
// Tab 1 — Confetti Showcase
// ─────────────────────────────────────────────────────
class ConfettiShowcasePage extends StatefulWidget {
  const ConfettiShowcasePage({super.key});
  @override
  State<ConfettiShowcasePage> createState() => _ConfettiShowcasePageState();
}

class _ConfettiShowcasePageState extends State<ConfettiShowcasePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late ConfettieController _ctrl;
  late AnimationController _pulse;
  int _sel = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _ctrl = ConfettieController(duration: const Duration(seconds: 5));
    _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _pulse.dispose();
    super.dispose();
  }

  ConfettiePreset get _cur => allPresets[_sel];

  void _fire() { _ctrl.duration = const Duration(seconds: 5); _ctrl.play(); }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ConfettieWidget(
      controller: _ctrl,
      shapes: _cur.shapes,
      colors: _cur.colors,
      numberOfParticles: _cur.numberOfParticles,
      gravity: _cur.gravity,
      blastForce: _cur.blastForce,
      drag: _cur.drag,
      blastDirection: _cur.blastDirection,
      emissionSource: _cur.emissionSource,
      emissionBehavior: _cur.emissionBehavior,
      particlesPerSecond: _cur.particlesPerSecond,
      child: SafeArea(child: _body()),
    );
  }

  Widget _body() => Column(children: [
    _header(),
    _heroCard(),
    _launchBtn(),
    const SizedBox(height: 14),
    _gridLabel(),
    Expanded(child: _grid()),
    const SizedBox(height: 6),
  ]);

  Widget _header() => Padding(
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 4),
    child: Row(children: [
      AnimatedBuilder(
        animation: _pulse,
        builder: (_, __) {
          final scale = 1.0 + 0.06 * _pulse.value;
          return Transform.scale(
            scale: scale,
            child: Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [_cur.cardA, _cur.cardB]),
                boxShadow: [BoxShadow(color: _cur.cardA.withValues(alpha: 0.5), blurRadius: 12)],
              ),
              child: Center(child: Text(_cur.emoji, style: const TextStyle(fontSize: 18))),
            ),
          );
        },
      ),
      const SizedBox(width: 12),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ShaderMask(
          shaderCallback: (b) => LinearGradient(colors: [_cur.cardA, Colors.white]).createShader(b),
          child: Text('Confettie Plus',
            style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
        ),
        Text('${allPresets.length} presets',
          style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11)),
      ]),
      const Spacer(),
      _badge('v0.0.1'),
    ]),
  );

  Widget _badge(String t) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(colors: [_cur.cardA.withValues(alpha: 0.3), _cur.cardB.withValues(alpha: 0.3)]),
      border: Border.all(color: _cur.cardA.withValues(alpha: 0.4)),
    ),
    child: Text(t, style: GoogleFonts.outfit(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600)),
  );

  Widget _heroCard() => AnimatedContainer(
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeOutCubic,
    margin: const EdgeInsets.fromLTRB(20, 12, 20, 12),
    height: 118,
    decoration: BoxDecoration(
      gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [_cur.cardA, _cur.cardB]),
      borderRadius: BorderRadius.circular(22),
      boxShadow: [BoxShadow(color: _cur.cardA.withValues(alpha: 0.45), blurRadius: 28, offset: const Offset(0, 10))],
    ),
    child: Stack(children: [
      Positioned(right: -22, top: -22, child: _deco(120, 0.09)),
      Positioned(right: 50, bottom: -30, child: _deco(80, 0.06)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(children: [
          Text(_cur.emoji, style: const TextStyle(fontSize: 46)),
          const SizedBox(width: 14),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_cur.name, style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
              const SizedBox(height: 3),
              Text(_cur.description, style: GoogleFonts.outfit(fontSize: 12, color: Colors.white70)),
              const SizedBox(height: 6),
              Row(children: [
                _chip(Icons.grain, '${_cur.numberOfParticles} particles'),
                const SizedBox(width: 6),
                _chip(Icons.arrow_upward, _cur.blastDirection.name),
              ]),
            ],
          )),
        ]),
      ),
    ]),
  );

  Widget _deco(double s, double a) => Container(
    width: s, height: s,
    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: a)),
  );

  Widget _chip(IconData icon, String label) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white.withValues(alpha: 0.18),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: Colors.white, size: 10),
      const SizedBox(width: 3),
      Text(label, style: GoogleFonts.outfit(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
    ]),
  );

  Widget _launchBtn() => GestureDetector(
    onTap: _fire,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [_cur.cardA, _cur.cardB]),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: _cur.cardA.withValues(alpha: 0.55), blurRadius: 18, offset: const Offset(0, 7))],
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.celebration_rounded, color: Colors.white, size: 20),
        const SizedBox(width: 8),
        Text('Launch ${_cur.name}!',
          style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
      ]),
    ),
  );

  Widget _gridLabel() => Padding(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
    child: Row(children: [
      Text('Pick a style', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 12, fontWeight: FontWeight.w600)),
      const Spacer(),
      Text('Double-tap to launch', style: GoogleFonts.outfit(color: Colors.white24, fontSize: 10)),
    ]),
  );

  Widget _grid() => GridView.builder(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.88,
    ),
    itemCount: allPresets.length,
    itemBuilder: (_, i) {
      final p = allPresets[i];
      final sel = i == _sel;
      return GestureDetector(
        onTap: () => setState(() => _sel = i),
        onDoubleTap: () { setState(() => _sel = i); _fire(); },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            gradient: sel ? LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [p.cardA, p.cardB]) : null,
            color: sel ? null : const Color(0xFF12121E),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: sel ? p.cardA.withValues(alpha: 0.7) : Colors.white.withValues(alpha: 0.07),
              width: sel ? 1.5 : 1,
            ),
            boxShadow: sel ? [BoxShadow(color: p.cardA.withValues(alpha: 0.38), blurRadius: 12, offset: const Offset(0, 3))] : null,
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(p.emoji, style: TextStyle(fontSize: sel ? 26 : 21)),
            const SizedBox(height: 5),
            Text(p.name,
              style: GoogleFonts.outfit(color: sel ? Colors.white : Colors.white54, fontWeight: sel ? FontWeight.w700 : FontWeight.w500, fontSize: 9.5),
              textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
          ]),
        ),
      );
    },
  );
}
