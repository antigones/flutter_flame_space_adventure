import 'package:flutter_game/space_shooter_game.dart';
import 'bg_manager_stub.dart'
  if (dart.library.io) 'mobile_manager.dart'
  if (dart.library.html) 'web_manager.dart';

abstract class BGManager {
  factory BGManager() => getManager();

  void handleVisibility(SpaceShooterGame spaceShooterGame);

}