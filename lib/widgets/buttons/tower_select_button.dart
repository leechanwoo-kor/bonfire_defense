import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/ally/archer_tower.dart';
import 'package:bonfire_defense/components/ally/tower.dart';
import 'package:bonfire_defense/utils/game_config.dart';
import 'package:bonfire_defense/utils/tower_info.dart';
import 'package:flutter/material.dart';

class TowerSelectButtons extends GameDecoration with TapGesture {
  late List<TowerSelectButton> buttons;
  TowerSelectButton? selectedButton;
  TowerInfoWidget? selectedInfoWidget;
  TransparentTower? transparentTower;

  TowerSelectButtons({required super.position})
      : super(
          size: Vector2.all(18),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    initializeButtons();
  }

  void initializeButtons() {
    buttons = [
      createButton(
        offset: Vector2(0, 20),
        icon: Icons.ac_unit,
        towerType: TowerType.barrack,
      ),
      createButton(
        offset: Vector2(20, 0),
        icon: Icons.arrow_forward,
        towerType: TowerType.archer,
      ),
      createButton(
        offset: Vector2(0, -20),
        icon: Icons.account_balance,
        towerType: TowerType.dwarf,
      ),
      createButton(
        offset: Vector2(-20, 0),
        icon: Icons.accessibility,
        towerType: TowerType.mage,
      )
    ];

    for (var button in buttons) {
      gameRef.add(button);
    }
  }

  TowerSelectButton createButton({
    required Vector2 offset,
    required IconData icon,
    required TowerType towerType,
  }) {
    return TowerSelectButton(
      position: position + offset,
      icon: icon,
      onTapCallback: onButtonTap,
      towerInfo: TowerInfo.getInfo(towerType),
    );
  }

  void onButtonTap(TowerSelectButton tappedButton) {
    if (selectedButton != null) {
      if (selectedButton == tappedButton) {
        handleSameButtonTap(tappedButton);
        return;
      } else {
        selectedButton!.isSelected = false;
        transparentTower?.removeFromParent();
        transparentTower = null;
      }
    }

    handleNewButtonTap(tappedButton);
  }

  void handleSameButtonTap(TowerSelectButton tappedButton) {
    addTower(tappedButton.towerInfo);
    transparentTower?.removeFromParent();
    transparentTower = null;
    selectedButton!.isSelected = false;
    selectedButton = null;
    selectedInfoWidget?.removeFromParent();
    selectedInfoWidget = null;
    removeButtons();
  }

  void addTower(TowerInfo towerInfo) {
    Tower tower;
    switch (towerInfo.type) {
      // case TowerType.barrack:
      //   tower = BarrackTower(position.clone());
      //   break;
      case TowerType.archer:
        tower = ArcherTower(position.clone());
        break;
      // case TowerType.dwarf:
      //   tower = DwarfTower(position.clone());
      //   break;
      // case TowerType.mage:
      //   tower = MageTower(position.clone());
      //   break;
      default:
        throw Exception('Invalid TowerType');
    }
    gameRef.add(tower);
  }

  void handleNewButtonTap(TowerSelectButton tappedButton) {
    selectedButton = tappedButton;
    tappedButton.isSelected = true;
    updateInfoWidget(tappedButton.towerInfo);
    addTransparentTower(tappedButton.towerInfo);
  }

  void updateInfoWidget(TowerInfo towerInfo) {
    final mapCenterX = gameRef.map.size.x / 2;
    final infoPosition = position.x > mapCenterX
        ? position + Vector2(-140, -20)
        : position + Vector2(40, -20);

    selectedInfoWidget?.removeFromParent();
    selectedInfoWidget = TowerInfoWidget(
      towerInfo: towerInfo,
      position: infoPosition,
    );
    gameRef.add(selectedInfoWidget!);
  }

  void addTransparentTower(TowerInfo towerInfo) {
    transparentTower = TransparentTower(
      position: position - Vector2(0, 16),
      towerInfo: towerInfo,
    );
    gameRef.add(transparentTower!);
  }

  void removeButtons() {
    for (var button in buttons) {
      button.removeFromParent();
    }
    buttons.clear();
    selectedButton = null;
    selectedInfoWidget?.removeFromParent();
    selectedInfoWidget = null;
    transparentTower?.removeFromParent();
    transparentTower = null;
  }

  bool anyButtonTapped() {
    return buttons.any((button) => button.isTapped);
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

class TowerSelectButton extends GameDecoration with TapGesture {
  final IconData icon;
  final void Function(TowerSelectButton) onTapCallback;
  final TowerInfo towerInfo;
  bool isTapped = false;
  bool isSelected = false;

  TowerSelectButton({
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

    drawButtonBackground(canvas);
    drawIcon(canvas);
    drawCost(canvas);
  }

  void drawButtonBackground(Canvas canvas) {
    final paint = Paint()..color = isSelected ? Colors.green : Colors.white;
    final radius = size.x / 2;
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), radius, paint);
  }

  void drawIcon(Canvas canvas) {
    const iconSize = 12.0;
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

  void drawCost(Canvas canvas) {
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
    drawBackground(canvas);
    drawText(canvas);
  }

  void drawBackground(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(0, 0, size.x, size.y);
    canvas.drawRect(rect, paint);
  }

  void drawText(Canvas canvas) {
    drawName(canvas);
    drawIconAndText(
      canvas,
      Icons.bolt,
      ' ${towerInfo.attackType}',
      const Offset(10, 30),
      Colors.black,
    );
    drawIconAndText(
      canvas,
      Icons.whatshot,
      ' ${towerInfo.attackDamage}',
      const Offset(70, 30),
      Colors.black,
    );
  }

  void drawName(Canvas canvas) {
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

  void drawIconAndText(
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
  }) : super(size: Vector2(16, 32));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox(size: size));
    loadTowerSprite();
  }

  Future<void> loadTowerSprite() async {
    final towerSprite = await Sprite.load(towerInfo.imagePath);
    add(SpriteComponent(
      sprite: towerSprite,
      size: size,
      paint: Paint()..color = Colors.white.withOpacity(0.5),
    ));
  }
}
