import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';

class StartButton extends StatefulWidget {
  final Offset position;

  const StartButton({required this.position, super.key});

  @override
  _StartButtonState createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500), // 애니메이션 주기를 0.5초로 설정
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.9, end: 1.1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<GameStateProvider, bool>(
      selector: (_, state) => state.state == GameState.waving,
      builder: (context, isWaving, __) {
        if (isWaving) {
          _controller.stop();
          return const SizedBox.shrink();
        } else {
          _controller.repeat(reverse: true);
          return Positioned(
            top: widget.position.dy,
            left: widget.position.dx,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animation.value,
                  child: RawMaterialButton(
                    onPressed: () {
                      Provider.of<GameStateProvider>(context, listen: false)
                          .startGame();
                    },
                    fillColor: Colors.black,
                    shape: const CircleBorder(),
                    constraints: const BoxConstraints.tightFor(
                      width: 30.0,
                      height: 30.0,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 18.0,
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
