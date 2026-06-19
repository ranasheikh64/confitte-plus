import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'confetti_page.dart';
import 'background_page.dart';

void main() => runApp(const ConfettiePlusExampleApp());

class ConfettiePlusExampleApp extends StatelessWidget {
  const ConfettiePlusExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Confettie Plus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7C3AED)),
        useMaterial3: true,
        textTheme: GoogleFonts.outfitTextTheme(),
      ),
      home: const RootShell(),
    );
  }
}

class RootShell extends StatefulWidget {
  const RootShell({super.key});
  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _tab = 0;

  static const _pages = <Widget>[
    ConfettiShowcasePage(),
    BackgroundShowcasePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080812),
      body: IndexedStack(index: _tab, children: _pages),
      bottomNavigationBar: _BottomNav(
        current: _tab,
        onTap: (i) => setState(() => _tab = i),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int current;
  final ValueChanged<int> onTap;
  const _BottomNav({required this.current, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A16),
        border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.07))),
      ),
      child: Row(children: [
        _NavItem(icon: Icons.celebration_rounded, label: 'Confetti', active: current == 0, onTap: () => onTap(0), activeColor: const Color(0xFFFF4081)),
        _NavItem(icon: Icons.auto_awesome_rounded, label: 'Backgrounds', active: current == 1, onTap: () => onTap(1), activeColor: const Color(0xFF9D6FFF)),
      ]),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;
  final Color activeColor;

  const _NavItem({required this.icon, required this.label, required this.active, required this.onTap, required this.activeColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              decoration: BoxDecoration(
                color: active ? activeColor.withValues(alpha: 0.15) : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, color: active ? activeColor : Colors.white24, size: 22),
            ),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(
              color: active ? activeColor : Colors.white24,
              fontSize: 11,
              fontWeight: active ? FontWeight.w700 : FontWeight.w400,
              fontFamily: 'Outfit',
            )),
          ],
        ),
      ),
    );
  }
}
