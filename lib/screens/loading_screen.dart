import 'package:bonfire_defense/screens/game.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  final Future<void> Function() onLoadComplete;

  const LoadingScreen({super.key, required this.onLoadComplete});

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward().then((_) async {
      await widget.onLoadComplete();

      _controller.reverse().then((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BonfireDefense()),
        );
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1b1b1b),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: 0.5 * _animation.value,
                    heightFactor: 1.0,
                    child: Container(color: const Color(0xff4e342e)),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FractionallySizedBox(
                    widthFactor: 0.5 * _animation.value,
                    heightFactor: 1.0,
                    child: Container(color: const Color(0xff4e342e)),
                  ),
                ),
                const Center(
                  child: Text(
                    'Loading...',
                    style: TextStyle(
                      fontFamily: 'MedievalSharp',
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
