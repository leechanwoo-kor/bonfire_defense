import 'package:bonfire/bonfire.dart';

class CameraController {
  final BonfireGameInterface gameRef;
  final double mapWidth;
  final double mapHeight;

  static const double minZoom = 1.5;
  static const double maxZoom = 3.0;
  static const double zoomSensitivity = 0.2;
  static const double panSensitivity = 0.2;

  CameraController(this.gameRef, this.mapWidth, this.mapHeight);

  void zoomIn() {
    _animateZoom(gameRef.camera.zoom * 1.1);
  }

  void zoomOut() {
    _animateZoom(gameRef.camera.zoom / 1.1);
  }

  void setZoom(double newZoom) {
    _animateZoom(newZoom);
  }

  void _animateZoom(double newZoom) {
    final clampedZoom = newZoom.clamp(minZoom, maxZoom);
    gameRef.camera.animateZoom(
      zoom: Vector2(clampedZoom, clampedZoom),
      effectController: EffectController(duration: 0.2),
    );
  }

  void moveCameraToPosition(Vector2 position) {
    gameRef.camera.moveToPositionAnimated(
      position: _clampPosition(position),
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
    final adjustedOffset = offset * panSensitivity;
    final newPosition = gameRef.camera.position + adjustedOffset;
    gameRef.camera.moveToPositionAnimated(
      position: _clampPosition(newPosition),
      effectController: EffectController(duration: 0.1),
    );
  }

  Vector2 _clampPosition(Vector2 position) {
    final clampedX = position.x.clamp(mapWidth * 0.4, mapWidth * 0.45);
    final clampedY = position.y.clamp(mapHeight * 0.85, mapHeight);
    return Vector2(clampedX, clampedY);
  }
}
