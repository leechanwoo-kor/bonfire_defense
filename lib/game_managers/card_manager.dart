import 'package:bonfire_defense/components/defenderInfo.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';

class CardManager {
  List<DefenderInfo> availableCards = DefenderInfo.getInfos();

  void selectCard(
      DefenderInfo card, DefenderStateProvider defenderStateProvider) {}
}
