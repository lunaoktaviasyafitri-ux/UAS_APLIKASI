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

// --- LAYAR 1: MENU UTAMA ---
class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundAesthetic(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("✨", style: TextStyle(fontSize: 60)),
              const SizedBox(height: 20),
              const Text(
                "Emoji Match",
                style: TextStyle(
                  fontSize: 40,
                  letterSpacing: 5,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFD87093),
                  shadows: [Shadow(color: Colors.white, blurRadius: 10)],
                ),
              ),
              const Text(
                "Aesthetic Memory Game",
                style: TextStyle(
                  color: Color(0xFFC71585),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 80),
              const AnimatedCuteButton(
                label:"PLAY"
                nextScreen: VariantSelectionScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- LAYER 2: PILIH KATEGORI ---
class VariantSelectionScreen extends StatefulWidget {
  const VariantSelectionScreen({super.key});

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundAesthetic(
        child: Column(
          children: [
            const SizedBox(height: 70),
            const Text(
              "PILIH KATEGORI",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color:  Color(0xFFD87093),
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                children: [
                  _variantCard(context, "🐶 HEWAN LUCU", [
                    "🐶",
                    "🐱",
                    "🐱",
                    "🐶",
                    "🐱",
                    "🐭",
                  ]),
                  const SizedBox(height: 20),
                  _variantCard(context, "🍎 BUAH SEGAR", [
                    "🍎",
                    "🍐",
                    "🍊",
                    "🍎",
                    "🍐",
                    "🍊",
                  ]),
                  const SizedBox(height: 20),
                  _variantCard(context, "🍕 JAJANAN",[
                    "🍕",
                    "🍔",
                    "🍟",
                    "🍕",
                    "🍔",
                    "🍟",
                  ]),
                ], 
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _varianCard(BuildContext context, String title, List<String> emojis) {
    return GestureDetector(
      onTap: () => Navigator.pust(
        context,
        MaterialPageRoute(builder: (context) => GamePlayScreen(emojis: emojis)),
      ),
      child: Container(
        height: 85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white.withOpacity(0.7),
          border: Border.all(color: const Color(0xFFFFB6C1), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withOpacity(0,1),
              blurRadius: 10,
             offset: const Offset(0, 5)
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFD87093),
            ),
          ),
        ),
      ),
    );
  }
}
