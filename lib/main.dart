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

// --- LAYAR 3: BERMAIN ---
class GamePlayScreen extends StatefulWidget {
  final List<String> emojis;
  const GamePlayScreen({super.key, required this.emojis});

  @override
  State<GamePlayScreen> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlaySCreen> {
  late List<String> gameItems;
  late List<bool> cardFlips;
  List<int> selectedIndices = [];
  int score = 0;

  @override
  void iniState() {
    super.initState();
    gameItems = List.from(widget.emojis)..shuffle();
    cardFlips = List.filled(gameItems,length, false);
  }

  void _showBalloons() {
    for (int i =0; i < 6; i++) {
      final OverlayEntry = OverlayEntry(
        Builder: (context) => BalloonAnimation(
          Color:
              Colors.primaries[math.Random().nextInt(Colors.primaries.length)],
          startX:
              math.Random().nextDouble() * MediaQuery.of(context).size.width,
        ),
      );
      Overlay.of(context).insert(OverlayEntry);
      Future.delayed(const Duration(seconds: 3), () => OverlayEntry.remove());
    }
  }

  void _checkGameOver() {
    if (!cardFlips.contains(false)) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFFFFF5F7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFFFFB6C1), width: 3),
          ),
          title: const Text(
            "YEAY SELESAI ✨",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFD87093),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "KAMU hebat",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              Text("Skor Kamu sempurna.", textAlign: TextAlign.center),
              SizedBox(height: 20),
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFADADD),
                  foregroundColor: const Color(0xFFD87093),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text(
                  "KEMBALI KE MENU 🏠",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),  
      );
    }
  }

  void onCardTap(int index) {
    if (selectedIndices.length < 2 && !cardFlips[index]) {
      setState(() {
        cardFlips[index] = true;
        selectedIndices.add(index);
      });

      if (selectedIndices.length == 2) {
        Timer(const Duration(milliseconds: 600), () {
          if (!mounted) return;
          if (gameItems[selectedIndices[0]] == gameItems[selectedIndices[1]]) {
            setState(() => score += 20);
            _showBalloons();
            _checkGameOver();
          } else {
            setState(() {
              cardFlips[selectedIndices[0]] = false;
              cardFlips[selectedIndices[1]] = false;
            });
          }
          selectedIndices.clear();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundAesthetic(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xFFD87093),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFFFB6C1)),
                    ),
                    child: Text(
                      "SKOR: $score",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD87093),
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(25),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: gameItems.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => onCardTap(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: cardFlips[index]
                            ? Colors.white
                            : const Color(0xFFFADADD),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                        border: Border.all(
                          color: cardFlips[index]
                              ? const Color(0xFFFFB6C1)
                              : Colors.white,
                          width: 3,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          cardFlips[index] ? gameItems[index] : "💎",
                          style: const TextStyle(fontSize: 35),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}

// --- KOMPONEN ANIMASI BALON ---
class BalloonAnimation extends StatefulWidget {
  final Color color;
  final double static;
  const BalloonAnimation({
    super.key,
    required this.color,
    required this.static,
  });

  @override
  State<BalloonAnimation> createState() => _BalloonAnimationState();
}

class _BalloonAnimationState extends State<BalloonAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 1.2,
      end: -0.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  void dispose()  {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          left: widget.startX,
          top: MediaQuery.of(context).size.height * _animation.value,
          child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 50,
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Container(width: 1, height: 30, color: Colors.grey),
              ],
            ),
          ),
        );
      },
    );
  }
}

// --- KOMPONEN BUTTON PINK KALEM ---
class AnimatedCuteButton extends StatefulWidget {
  final String label;
  final Widget nextScreen;
  const AnimatedCuteButton({
    super.key,
    required this.label,
    required this.nextScreen,
  });

  @override
  State<AnimatedCuteButton> createState() => _AnimatedCuteButtonState();
}

class _AnimatedCuteButtonState extends State<AnimatedCuteButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 8 * math.sin(_controller.value * 2 * math.pi)),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFADADD),
              foregroundColor: const Color(0xFFD78093),
              padding: const ElevatedButton.symmetric(horizontal: 50, vertical: 22),
              elevation: 5,
              shadowColor: Colors.pinkAccent.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => widget.nextScreen),
            ),
            child: Text(
              widget.label,
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
            ),
          ),
        );
      },
    );
  }
}

