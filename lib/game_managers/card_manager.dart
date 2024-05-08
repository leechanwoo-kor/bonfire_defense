import 'package:bonfire_defense/components/defenderCard.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';

class CardManager {
  List<DefenderCard> availableCards = DefenderCard.getCards();

  void selectCard(
      DefenderCard card, DefenderStateProvider defenderStateProvider) {}
}
