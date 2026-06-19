import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confettie_plus/confettie_plus.dart';

// ─────────────────────────────────────────────────────
// Tab 2 — Animated Background Showcase
// ─────────────────────────────────────────────────────
class BackgroundShowcasePage extends StatefulWidget {
  const BackgroundShowcasePage({super.key});
  @override
  State<BackgroundShowcasePage> createState() => _BackgroundShowcasePageState();
}

class _BackgroundShowcasePageState extends State<BackgroundShowcasePage>
    with AutomaticKeepAliveClientMixin {
  int _bgType = 0; // 0=Sun, 1=Moon, 2=Galaxy

  // Sun settings
  double _sunSize = 180;
  Color _sunColor = const Color(0xFFFFD700);
  int _sunRays = 12;
  bool _sunGlow = true;
  double _sunSpeed = 1.0;

  // Moon settings
  double _moonSize = 160;
  Color _moonColor = const Color(0xFFFFF8E7);
  MoonPhase _moonPhase = MoonPhase.crescent;
  int _moonStars = 30;
  double _moonSpeed = 1.0;

  // Galaxy settings
  Color _galaxyPrimary = const Color(0xFF7C3AED);
  Color _galaxySecondary = const Color(0xFF1E3A5F);
  int _galaxyStars = 150;
  bool _galaxyNebula = true;
  double _galaxySpeed = 1.0;

  @override
  bool get wantKeepAlive => true;

  static const _bgNames = ['Sun ☀️', 'Moon 🌙', 'Galaxy 🌌'];
  static const _bgIcons = [Icons.wb_sunny_rounded, Icons.nights_stay_rounded, Icons.auto_awesome_rounded];
  static const _bgColors = [Color(0xFFF59E0B), Color(0xFF6366F1), Color(0xFF7C3AED)];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(child: Column(children: [
      _header(),
      _preview(),
      _typeSelector(),
      Expanded(child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: _controls(),
      )),
    ]));
  }

  Widget _header() => Padding(
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
    child: Row(children: [
      Container(
        width: 36, height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(colors: [_bgColors[_bgType], _bgColors[_bgType].withValues(alpha: 0.5)]),
          boxShadow: [BoxShadow(color: _bgColors[_bgType].withValues(alpha: 0.4), blurRadius: 10)],
        ),
        child: Icon(_bgIcons[_bgType], color: Colors.white, size: 18),
      ),
      const SizedBox(width: 12),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Animated Backgrounds', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
        Text('Natural · Animated · Customizable', style: GoogleFonts.outfit(fontSize: 11, color: Colors.white38)),
      ]),
    ]),
  );

  // ─── Preview ────────────────────────────────────────
  Widget _preview() => Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    height: 220,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      color: _bgType == 0 ? const Color(0xFF0B1A2E) : _bgType == 1 ? const Color(0xFF05071A) : const Color(0xFF060610),
      boxShadow: [BoxShadow(color: _bgColors[_bgType].withValues(alpha: 0.3), blurRadius: 24, offset: const Offset(0, 8))],
      border: Border.all(color: _bgColors[_bgType].withValues(alpha: 0.2)),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(children: [
        if (_bgType == 0) _sunPreview(),
        if (_bgType == 1) _moonPreview(),
        if (_bgType == 2) _galaxyPreview(),
        // Label overlay
        Positioned(bottom: 14, left: 16, child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_bgNames[_bgType],
              style: GoogleFonts.outfit(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
            Text('Widget background preview',
              style: GoogleFonts.outfit(color: Colors.white54, fontSize: 11)),
          ],
        )),
        Positioned(bottom: 14, right: 16, child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.black38, borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white12),
          ),
          child: Text('Live Preview', style: GoogleFonts.outfit(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w600)),
        )),
      ]),
    ),
  );

  Widget _sunPreview() => AnimatedSunBackground(
    size: _sunSize,
    color: _sunColor,
    rayCount: _sunRays,
    showGlow: _sunGlow,
    speed: _sunSpeed,
    alignment: Alignment.center,
    child: Container(color: const Color(0xFF0B1A2E)),
  );

  Widget _moonPreview() => AnimatedMoonBackground(
    size: _moonSize,
    moonColor: _moonColor,
    moonPhase: _moonPhase,
    starCount: _moonStars,
    speed: _moonSpeed,
    alignment: Alignment.center,
    child: Container(color: const Color(0xFF05071A)),
  );

  Widget _galaxyPreview() => AnimatedGalaxyBackground(
    starCount: _galaxyStars,
    primaryColor: _galaxyPrimary,
    secondaryColor: _galaxySecondary,
    showNebula: _galaxyNebula,
    speed: _galaxySpeed,
    child: const SizedBox.expand(),
  );

  // ─── Type Selector ───────────────────────────────────
  Widget _typeSelector() => Padding(
    padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
    child: Row(children: List.generate(3, (i) {
      final sel = i == _bgType;
      return Expanded(child: GestureDetector(
        onTap: () => setState(() => _bgType = i),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          margin: EdgeInsets.only(right: i < 2 ? 10 : 0),
          height: 44,
          decoration: BoxDecoration(
            gradient: sel ? LinearGradient(colors: [_bgColors[i], _bgColors[i].withValues(alpha: 0.6)]) : null,
            color: sel ? null : const Color(0xFF12121E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: sel ? _bgColors[i] : Colors.white.withValues(alpha: 0.08)),
            boxShadow: sel ? [BoxShadow(color: _bgColors[i].withValues(alpha: 0.4), blurRadius: 10, offset: const Offset(0, 3))] : null,
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(_bgIcons[i], color: sel ? Colors.white : Colors.white38, size: 16),
            const SizedBox(width: 6),
            Text(_bgNames[i].split(' ').first,
              style: GoogleFonts.outfit(color: sel ? Colors.white : Colors.white38, fontSize: 13, fontWeight: FontWeight.w600)),
          ]),
        ),
      ));
    })),
  );

  // ─── Controls ───────────────────────────────────────
  Widget _controls() {
    if (_bgType == 0) return _sunControls();
    if (_bgType == 1) return _moonControls();
    return _galaxyControls();
  }

  Widget _sunControls() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _sectionTitle('Sun Customization'),
    _sliderTile('Size', _sunSize, 60, 300, (v) => setState(() => _sunSize = v), '${_sunSize.round()}px'),
    _sliderTile('Speed', _sunSpeed, 0.2, 3.0, (v) => setState(() => _sunSpeed = v), '${_sunSpeed.toStringAsFixed(1)}x'),
    _sliderTile('Rays', _sunRays.toDouble(), 4, 24, (v) => setState(() => _sunRays = v.round()), '$_sunRays'),
    _colorPicker('Sun Color', _sunColor, (c) => setState(() => _sunColor = c), _sunColorPalette),
    _switchTile('Glow Halo', _sunGlow, (v) => setState(() => _sunGlow = v)),
    _codeSnippet('AnimatedSunBackground(\n  size: ${_sunSize.round()},\n  color: Color(0x${_sunColor.toARGB32().toRadixString(16).toUpperCase().padLeft(8, '0')}),\n  rayCount: $_sunRays,\n  showGlow: $_sunGlow,\n  speed: ${_sunSpeed.toStringAsFixed(1)},\n  child: YourWidget(),\n)'),
  ]);

  Widget _moonControls() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _sectionTitle('Moon Customization'),
    _sliderTile('Size', _moonSize, 60, 300, (v) => setState(() => _moonSize = v), '${_moonSize.round()}px'),
    _sliderTile('Speed', _moonSpeed, 0.2, 3.0, (v) => setState(() => _moonSpeed = v), '${_moonSpeed.toStringAsFixed(1)}x'),
    _sliderTile('Stars', _moonStars.toDouble(), 0, 80, (v) => setState(() => _moonStars = v.round()), '$_moonStars'),
    _moonPhasePicker(),
    _colorPicker('Moon Color', _moonColor, (c) => setState(() => _moonColor = c), _moonColorPalette),
    _codeSnippet('AnimatedMoonBackground(\n  size: ${_moonSize.round()},\n  moonColor: Color(0x${_moonColor.toARGB32().toRadixString(16).toUpperCase().padLeft(8, '0')}),\n  moonPhase: MoonPhase.${_moonPhase.name},\n  starCount: $_moonStars,\n  speed: ${_moonSpeed.toStringAsFixed(1)},\n  child: YourWidget(),\n)'),
  ]);

  Widget _galaxyControls() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _sectionTitle('Galaxy Customization'),
    _sliderTile('Stars', _galaxyStars.toDouble(), 20, 300, (v) => setState(() => _galaxyStars = v.round()), '$_galaxyStars'),
    _sliderTile('Speed', _galaxySpeed, 0.2, 3.0, (v) => setState(() => _galaxySpeed = v), '${_galaxySpeed.toStringAsFixed(1)}x'),
    _colorPicker('Primary Nebula', _galaxyPrimary, (c) => setState(() => _galaxyPrimary = c), _galaxyPrimaryPalette),
    _colorPicker('Secondary Nebula', _galaxySecondary, (c) => setState(() => _galaxySecondary = c), _galaxySecondaryPalette),
    _switchTile('Show Nebula Glow', _galaxyNebula, (v) => setState(() => _galaxyNebula = v)),
    _codeSnippet('AnimatedGalaxyBackground(\n  starCount: $_galaxyStars,\n  primaryColor: Color(0x${_galaxyPrimary.toARGB32().toRadixString(16).toUpperCase().padLeft(8, '0')}),\n  secondaryColor: Color(0x${_galaxySecondary.toARGB32().toRadixString(16).toUpperCase().padLeft(8, '0')}),\n  showNebula: $_galaxyNebula,\n  speed: ${_galaxySpeed.toStringAsFixed(1)},\n  child: YourWidget(),\n)'),
  ]);

  // ─── Moon Phase Picker ────────────────────────────
  Widget _moonPhasePicker() {
    const phases = MoonPhase.values;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 4),
        child: Text('Moon Phase', style: GoogleFonts.outfit(color: Colors.white60, fontSize: 13)),
      ),
      Row(children: List.generate(phases.length, (i) {
        final p = phases[i];
        final sel = p == _moonPhase;
        return Expanded(child: GestureDetector(
          onTap: () => setState(() => _moonPhase = p),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: EdgeInsets.only(right: i < phases.length - 1 ? 8 : 0),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: sel ? const Color(0xFF6366F1).withValues(alpha: 0.3) : const Color(0xFF12121E),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: sel ? const Color(0xFF6366F1) : Colors.white.withValues(alpha: 0.08),
                width: sel ? 1.5 : 1,
              ),
              boxShadow: sel ? [BoxShadow(color: const Color(0xFF6366F1).withValues(alpha: 0.4), blurRadius: 10)] : null,
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(p.emoji, style: TextStyle(fontSize: sel ? 22 : 18)),
              const SizedBox(height: 4),
              Text(p.label,
                style: GoogleFonts.outfit(
                  color: sel ? Colors.white : Colors.white38,
                  fontSize: 9,
                  fontWeight: sel ? FontWeight.w700 : FontWeight.w400,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ]),
          ),
        ));
      })),
      const SizedBox(height: 14),
    ]);
  }

  // ─── Reusable control widgets ─────────────────────
  Widget _sectionTitle(String t) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(t, style: GoogleFonts.outfit(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
  );

  Widget _sliderTile(String label, double val, double min, double max, ValueChanged<double> onChanged, String display) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Text(label, style: GoogleFonts.outfit(color: Colors.white60, fontSize: 13)),
        const Spacer(),
        Text(display, style: GoogleFonts.outfit(color: _bgColors[_bgType], fontSize: 13, fontWeight: FontWeight.w700)),
      ]),
      SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: _bgColors[_bgType],
          thumbColor: _bgColors[_bgType],
          inactiveTrackColor: Colors.white12,
          overlayColor: _bgColors[_bgType].withValues(alpha: 0.2),
          trackHeight: 3,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
        ),
        child: Slider(value: val.clamp(min, max), min: min, max: max, onChanged: onChanged),
      ),
      const SizedBox(height: 4),
    ]);
  }

  Widget _colorPicker(String label, Color current, ValueChanged<Color> onChanged, List<Color> palette) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 4),
        child: Text(label, style: GoogleFonts.outfit(color: Colors.white60, fontSize: 13)),
      ),
      SizedBox(
        height: 36,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: palette.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (_, i) {
            final c = palette[i];
            final sel = c.toARGB32() == current.toARGB32();
            return GestureDetector(
              onTap: () => onChanged(c),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 36, height: 36,
                decoration: BoxDecoration(
                  color: c,
                  shape: BoxShape.circle,
                  border: Border.all(color: sel ? Colors.white : Colors.transparent, width: sel ? 2.5 : 0),
                  boxShadow: sel ? [BoxShadow(color: c.withValues(alpha: 0.6), blurRadius: 8)] : null,
                ),
                child: sel ? const Icon(Icons.check, color: Colors.white, size: 16) : null,
              ),
            );
          },
        ),
      ),
      const SizedBox(height: 14),
    ]);
  }

  Widget _switchTile(String label, bool val, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(children: [
        Text(label, style: GoogleFonts.outfit(color: Colors.white60, fontSize: 13)),
        const Spacer(),
        Switch(
          value: val,
          onChanged: onChanged,
          activeThumbColor: _bgColors[_bgType],
          activeTrackColor: _bgColors[_bgType].withValues(alpha: 0.5),
          inactiveTrackColor: Colors.white12,
        ),
      ]),
    );
  }

  Widget _codeSnippet(String code) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D1A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _bgColors[_bgType].withValues(alpha: 0.3)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(Icons.code_rounded, color: _bgColors[_bgType], size: 14),
          const SizedBox(width: 6),
          Text('Usage', style: GoogleFonts.outfit(color: _bgColors[_bgType], fontSize: 12, fontWeight: FontWeight.w600)),
        ]),
        const SizedBox(height: 8),
        Text(code, style: GoogleFonts.sourceCodePro(color: Colors.white60, fontSize: 11, height: 1.6)),
      ]),
    );
  }

  // ─── Color palettes ─────────────────────────────────
  static const _sunColorPalette = [
    Color(0xFFFFD700), Color(0xFFFFA500), Color(0xFFFF6B35),
    Color(0xFFFF8C00), Color(0xFFFFEC5C), Color(0xFFFFB347),
    Color(0xFFFFF5B7), Color(0xFFFF4500),
  ];

  static const _moonColorPalette = [
    Color(0xFFFFF8E7), Color(0xFFF5E6CA), Color(0xFFE8D5B0),
    Color(0xFFD4C5A9), Color(0xFFC8E6FF), Color(0xFFB0D4F1),
    Color(0xFFE8F0FF), Color(0xFFFFFFFF),
  ];

  static const _galaxyPrimaryPalette = [
    Color(0xFF7C3AED), Color(0xFF2563EB), Color(0xFFDB2777),
    Color(0xFF059669), Color(0xFFDC2626), Color(0xFF9333EA),
    Color(0xFF0EA5E9), Color(0xFF6366F1),
  ];

  static const _galaxySecondaryPalette = [
    Color(0xFF1E3A5F), Color(0xFF0D1B2A), Color(0xFF1A1A2E),
    Color(0xFF16213E), Color(0xFF0F3460), Color(0xFF162032),
    Color(0xFF1B0033), Color(0xFF003333),
  ];
}
