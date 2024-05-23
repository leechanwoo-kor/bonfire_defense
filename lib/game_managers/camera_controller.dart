import 'package:bonfire/bonfire.dart';

class CameraController {
  final BonfireGameInterface gameRef;

  CameraController(this.gameRef);

  // 카메라 기능 구현
  void zoomIn() {
    final newZoom = (gameRef.camera.zoom * 1.1).clamp(1.0, 3.0);
    gameRef.camera.animateZoom(
      zoom: Vector2(newZoom, newZoom),
      effectController: EffectController(duration: 0.2),
    );
  }

  void zoomOut() {
    final newZoom = (gameRef.camera.zoom / 1.1).clamp(1.0, 3.0);
    gameRef.camera.animateZoom(
      zoom: Vector2(newZoom, newZoom),
      effectController: EffectController(duration: 0.2),
    );
  }

  void moveCameraToPosition(Vector2 position) {
    gameRef.camera.moveToPositionAnimated(
      position: position,
      effectController: EffectController(duration: 1.0),
    );
  }

  void followPlayer() {
    gameRef.camera.moveToPlayerAnimated(
      effectController: EffectController(duration: 1.0),
    );
  }

  void shakeCamera() {
    gameRef.camera.shake(
      intensity: 20.0,
      duration: const Duration(seconds: 1),
    );
  }

  void moveCameraByOffset(Vector2 offset) {
    final adjustedOffset = offset * 0.2;
    final newPosition = gameRef.camera.position - adjustedOffset;
    gameRef.camera.moveToPositionAnimated(
      position: newPosition,
      effectController: EffectController(duration: 0.1),
    );
  }
}
