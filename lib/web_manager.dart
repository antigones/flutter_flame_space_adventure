import 'dart:html';
import 'package:flutter_game/bg_manager.dart';
import 'package:flutter_game/space_shooter_game.dart';

class WebManager implements BGManager {



  late SpaceShooterGame _spaceShooterGame;

  @override
  void handleVisibility(SpaceShooterGame spaceShooterGame) {
    _spaceShooterGame = spaceShooterGame;
    document.addEventListener("visibilitychange", onVisibilityChange);
  }

  void onVisibilityChange(Event e) {
    // do something
    if (document.visibilityState == 'visible') {
      print('foreground');
      _spaceShooterGame.resumeEngine();
      _spaceShooterGame.resumeGame();
    } else {
      print('background');
      _spaceShooterGame.pauseEngine();
      _spaceShooterGame.pauseGame();
    }
  }
}

BGManager getManager() => WebManager();