import 'package:bonfire_defense/screens/game.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  final Future<void> Function() onLoadComplete;

  const LoadingScreen({super.key, required this.onLoadComplete});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
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

    // 문이 닫히는 애니메이션 시작
    _controller.forward().then((_) async {
      // 데이터 초기화
      await widget.onLoadComplete();

      // 로딩 완료 후 문이 열리는 애니메이션
      _controller.reverse().then((_) {
        // 문이 열리는 애니메이션이 끝난 후 게임 화면으로 전환
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
                // 문 왼쪽
                Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: 0.5 * _animation.value,
                    heightFactor: 1.0,
                    child: Container(color: const Color(0xff4e342e)),
                  ),
                ),
                // 문 오른쪽
                Align(
                  alignment: Alignment.centerRight,
                  child: FractionallySizedBox(
                    widthFactor: 0.5 * _animation.value,
                    heightFactor: 1.0,
                    child: Container(color: const Color(0xff4e342e)),
                  ),
                ),
                // 중세 판타지 느낌의 텍스트 추가
                Center(
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
