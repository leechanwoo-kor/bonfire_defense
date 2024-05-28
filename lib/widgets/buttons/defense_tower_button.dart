import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/utils/game_config.dart';
import 'package:bonfire_defense/utils/tower_info.dart';
import 'package:flutter/material.dart';

class DefenseTowerButtons extends GameDecoration with TapGesture {
  late List<DefenseTowerButton> buttons;
  DefenseTowerButton? _selectedButton;
  TowerInfoWidget? _selectedInfoWidget;
  TransparentTower? _transparentTower;

  DefenseTowerButtons({required super.position})
      : super(
          size: Vector2.all(18),
        );

  @override
  void onMount() {
    super.onMount();
    _initializeButtons();
  }

  void _initializeButtons() {
    buttons = [
      _createButton(
        offset: Vector2(0, 20),
        icon: Icons.ac_unit,
        towerType: TowerType.barrack,
      ),
      _createButton(
        offset: Vector2(20, 0),
        icon: Icons.arrow_forward,
        towerType: TowerType.archer,
      ),
      _createButton(
        offset: Vector2(0, -20),
        icon: Icons.account_balance,
        towerType: TowerType.dwarf,
      ),
      _createButton(
        offset: Vector2(-20, 0),
        icon: Icons.accessibility,
        towerType: TowerType.mage,
      )
    ];

    for (var button in buttons) {
      gameRef.add(button);
    }
  }

  DefenseTowerButton _createButton({
    required Vector2 offset,
    required IconData icon,
    required TowerType towerType,
  }) {
    return DefenseTowerButton(
      position: position + offset,
      icon: icon,
      onTapCallback: _onButtonTap,
      towerInfo: TowerInfo.getInfo(towerType),
    );
  }

  void _onButtonTap(DefenseTowerButton tappedButton) {
    if (_selectedButton != null) {
      if (_selectedButton == tappedButton) {
        _handleSameButtonTap(tappedButton);
        return;
      } else {
        _selectedButton!.isSelected = false;
        _transparentTower?.removeFromParent();
        _transparentTower = null;
      }
    }

    _handleNewButtonTap(tappedButton);
  }

  void _handleSameButtonTap(DefenseTowerButton tappedButton) {
    print('타워를 추가하기 위해 버튼을 다시 클릭했습니다.');
    // _addTower(tappedButton.towerInfo);
    _transparentTower?.removeFromParent();
    _transparentTower = null;
    _selectedButton!.isSelected = false;
    _selectedButton = null;
    _selectedInfoWidget?.removeFromParent();
    _selectedInfoWidget = null;
    removeButtons();
  }

  void _handleNewButtonTap(DefenseTowerButton tappedButton) {
    _selectedButton = tappedButton;
    tappedButton.isSelected = true;
    _updateInfoWidget(tappedButton.towerInfo);
    _addTransparentTower(tappedButton.towerInfo);
  }

  void _updateInfoWidget(TowerInfo towerInfo) {
    final mapCenterX = gameRef.map.size.x / 2;
    final infoPosition = position.x > mapCenterX
        ? position + Vector2(-140, -20)
        : position + Vector2(40, -20);

    _selectedInfoWidget?.removeFromParent();
    _selectedInfoWidget = TowerInfoWidget(
      towerInfo: towerInfo,
      position: infoPosition,
    );
    gameRef.add(_selectedInfoWidget!);
  }

  void _addTransparentTower(TowerInfo towerInfo) {
    _transparentTower = TransparentTower(
      position: position,
      towerInfo: towerInfo,
    );
    gameRef.add(_transparentTower!);
  }

  void removeButtons() {
    for (var button in buttons) {
      button.removeFromParent();
    }
    buttons.clear();
    _selectedButton = null;
    _selectedInfoWidget?.removeFromParent();
    _selectedInfoWidget = null;
    _transparentTower?.removeFromParent();
    _transparentTower = null;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void onTap() {
    // 방어 타워 클릭 시 행동 정의
  }
}

class DefenseTowerButton extends GameDecoration with TapGesture {
  final IconData icon;
  final void Function(DefenseTowerButton) onTapCallback;
  final TowerInfo towerInfo;
  bool isTapped = false;
  bool isSelected = false;

  DefenseTowerButton({
    required super.position,
    required this.icon,
    required this.onTapCallback,
    required this.towerInfo,
  }) : super(
          size: Vector2.all(16),
        );

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    _drawButtonBackground(canvas);
    _drawIcon(canvas);
    _drawCost(canvas);
  }

  void _drawButtonBackground(Canvas canvas) {
    final paint = Paint()..color = isSelected ? Colors.green : Colors.white;
    final radius = size.x / 2;
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), radius, paint);
  }

  void _drawIcon(Canvas canvas) {
    final iconSize = 12.0;
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: iconSize,
          fontFamily: icon.fontFamily,
          color: Colors.black,
        ),
      ),
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset((size.x - iconSize) / 2, (size.y - iconSize) / 2),
    );
  }

  void _drawCost(Canvas canvas) {
    final costPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: '${towerInfo.cost}',
        style: const TextStyle(
          fontSize: 10,
          color: Colors.black,
        ),
      ),
    );

    costPainter.layout();
    costPainter.paint(
      canvas,
      Offset((size.x - costPainter.width) / 2, size.y + 2),
    );
  }

  @override
  void onTap() {
    isTapped = true;
    onTapCallback(this);
  }
}

class TowerInfoWidget extends GameDecoration {
  final TowerInfo towerInfo;

  TowerInfoWidget({
    required this.towerInfo,
    required super.position,
  }) : super(size: Vector2(120, 60));

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _drawBackground(canvas);
    _drawText(canvas);
  }

  void _drawBackground(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(0, 0, size.x, size.y);
    canvas.drawRect(rect, paint);
  }

  void _drawText(Canvas canvas) {
    _drawName(canvas);
    _drawIconAndText(
      canvas,
      Icons.bolt,
      ' ${towerInfo.attackType}',
      const Offset(10, 30),
      Colors.black,
    );
    _drawIconAndText(
      canvas,
      Icons.whatshot,
      ' ${towerInfo.attackDamage}',
      const Offset(70, 30),
      Colors.black,
    );
  }

  void _drawName(Canvas canvas) {
    final namePainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: towerInfo.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.black,
        ),
      ),
    );

    namePainter.layout();
    namePainter.paint(canvas, const Offset(10, 10));
  }

  void _drawIconAndText(
    Canvas canvas,
    IconData icon,
    String text,
    Offset offset,
    Color color,
  ) {
    final iconPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: 10,
          fontFamily: icon.fontFamily,
          color: color,
        ),
      ),
    );

    iconPainter.layout();
    iconPainter.paint(canvas, offset);

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 10,
          color: color,
        ),
      ),
    );

    textPainter.layout();
    textPainter.paint(canvas, offset + const Offset(14, 0));
  }
}

class TransparentTower extends GameDecoration {
  final TowerInfo towerInfo;

  TransparentTower({
    required super.position,
    required this.towerInfo,
  }) : super(size: Vector2.all(16));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox(size: size));
    _loadTransparentSprite();
  }

  Future<void> _loadTransparentSprite() async {
    final towerSprite = await Sprite.load(towerInfo.imagePath);
    add(SpriteComponent(
      sprite: towerSprite,
      size: size,
      paint: Paint()..color = Colors.white.withOpacity(0.5),
    ));
  }
}
