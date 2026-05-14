import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(const EmojiGameApp());
}

class EmojiGameApp extends StatelessWidget {
  const EmojiGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emoji March',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'sans-serif',
        useMaterial3: true,
      ),
      home: const MainMenuScreen(),
    );
  }
}

// --- KOMPONEN BACKGROUND CERAH & MENYALA ---
class BackgroundAesthetic extends StatelessWidget {
  final Widget child;
  const BackgroundAesthetic({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFFE4E1), // Misty Rose
                Color(0xFFFFB6C1), // Light Pink Menyala
                Color(0xFFFFF0F5), //Lavender Blush
              ],
            ),
          ),
        ),
        Positioned(
          top: -50,
          right: -50,
          child: _builOrd(180, const Color(0xFFFF69B4).withOpacity(0.2)),
        ),
        Positioned(
          bottom: 100,
          left: -30,
          child: _buildOrd(120, const Color(0xFFFFC0CB).withOpacity(0.3)),
        ),
        child,
      ],
    );
  }

  Widget _buildOrb(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [BoxShadow(color: color, blurRadius: 60, spreadRadius: 30)],
      ),
    );
  }
}
