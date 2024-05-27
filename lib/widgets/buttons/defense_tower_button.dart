import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/utils/game_config.dart';
import 'package:bonfire_defense/utils/tower_info.dart';
import 'package:flutter/material.dart';

class DefenseTowerButtons extends GameDecoration with TapGesture {
  late List<DefenseTowerButton> buttons;
  DefenseTowerButton? _selectedButton;
  TowerInfoWidget? _selectedInfoWidget;

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
      DefenseTowerButton(
        position: Vector2(position.x - 20, position.y),
        icon: Icons.ac_unit,
        onTapCallback: (tappedButton) => _onButtonTap(tappedButton),
        towerInfo: TowerInfo.getInfo(TowerType.barrack),
      ),
      DefenseTowerButton(
        position: Vector2(position.x + 20, position.y),
        icon: Icons.arrow_forward,
        onTapCallback: (tappedButton) => _onButtonTap(tappedButton),
        towerInfo: TowerInfo.getInfo(TowerType.archer),
      ),
      DefenseTowerButton(
        position: Vector2(position.x, position.y - 20),
        icon: Icons.accessibility,
        onTapCallback: (tappedButton) => _onButtonTap(tappedButton),
        towerInfo: TowerInfo.getInfo(TowerType.mage),
      ),
      DefenseTowerButton(
        position: Vector2(position.x, position.y + 20),
        icon: Icons.account_balance,
        onTapCallback: (tappedButton) => _onButtonTap(tappedButton),
        towerInfo: TowerInfo.getInfo(TowerType.dwarf),
      ),
    ];

    for (var button in buttons) {
      gameRef.add(button);
    }
  }

  void _onButtonTap(DefenseTowerButton tappedButton) {
    if (_selectedButton != null && _selectedButton != tappedButton) {
      _selectedButton!.isSelected = false;
    }

    // 이전에 선택된 DefenderInfoWidget 제거
    _selectedInfoWidget?.removeFromParent();

    _selectedButton = tappedButton;
    tappedButton.isSelected = true;

    // 맵의 중앙 좌표 계산
    final mapCenterX = gameRef.map.size.x / 2;

    // 위젯의 위치 계산
    Vector2 infoPosition;
    if (position.x > mapCenterX) {
      // 오른쪽에 있을 때 정보창을 왼쪽에 표시
      infoPosition = position + Vector2(-140, -20);
    } else {
      // 왼쪽에 있을 때 정보창을 오른쪽에 표시
      infoPosition = position + Vector2(40, -20);
    }

    // 새로운 DefenderInfoWidget 추가
    _selectedInfoWidget = TowerInfoWidget(
      towerInfo: tappedButton.towerInfo,
      position: infoPosition,
    );
    gameRef.add(_selectedInfoWidget!);
  }

  void removeButtons() {
    for (var button in buttons) {
      button.removeFromParent();
    }
    buttons.clear();
    _selectedButton = null;
    _selectedInfoWidget?.removeFromParent();
    _selectedInfoWidget = null;
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

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    final iconSize = 12.0;
    final textSpan = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        fontSize: iconSize,
        fontFamily: icon.fontFamily,
        color: Colors.black,
      ),
    );

    // 클릭 여부에 따라 색상 변경
    final paint = Paint()
      ..color =
          isSelected ? Colors.green : (isTapped ? Colors.white : Colors.white);
    double radius = size.x / 2;

    canvas.drawCircle(Offset(size.x / 2, size.y / 2), radius, paint);

    textPainter.text = textSpan;
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.x - iconSize) / 2,
        (size.y - iconSize) / 2,
      ),
    );

    // 비용 텍스트
    final costPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: '${towerInfo.cost}',
        style: TextStyle(
          fontSize: 10,
          color: Colors.black,
        ),
      ),
    );
    costPainter.layout();
    costPainter.paint(
      canvas,
      Offset(
        (size.x - costPainter.width) / 2,
        size.y + 2,
      ),
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
    required Vector2 position,
  }) : super(position: position, size: Vector2(120, 60));

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(0, 0, size.x, size.y);
    canvas.drawRect(rect, paint);

    // Tower 이름
    final namePainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: towerInfo.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.black,
        ),
      ),
    );
    namePainter.layout();
    namePainter.paint(canvas, Offset(10, 10));

    // Attack Type 아이콘과 텍스트
    _drawIconAndText(
      canvas,
      Icons.bolt,
      ' ${towerInfo.attackType}',
      Offset(10, 30),
      Colors.black,
    );

    // Attack Damage 아이콘과 텍스트
    _drawIconAndText(
      canvas,
      Icons.whatshot,
      ' ${towerInfo.attackDamage}',
      Offset(70, 30), // 같은 줄에 배치하기 위해 x좌표 조정
      Colors.black,
    );
  }

  void _drawIconAndText(
    Canvas canvas,
    IconData icon,
    String text,
    Offset offset,
    Color color,
  ) {
    // Draw icon
    TextPainter iconPainter = TextPainter(
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

    // Draw text next to icon
    TextPainter textPainter = TextPainter(
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
    textPainter.paint(canvas, offset + Offset(14, 0));
  }
}
