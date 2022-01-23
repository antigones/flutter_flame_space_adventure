import 'package:flutter_game/bg_manager.dart';
import 'package:flutter_game/space_shooter_game.dart';

class MobileManager implements BGManager {



  @override
  void handleVisibility(SpaceShooterGame spaceShooterGame) {
    // TODO: implement handleVisibility
  }

}

BGManager getManager() => MobileManager();