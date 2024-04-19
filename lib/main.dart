import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/routes/app_routes.dart'; // 업데이트된 라우트 설정 파일을 가져옵니다.
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bonfire Defense',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: AppRoutes.defineRoutes(), // 새로운 라우트 관리 메소드를 사용합니다.
    );
  }
}
