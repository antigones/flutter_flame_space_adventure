import 'dart:html';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game/player.dart';
import 'package:flutter_game/shoot.dart';

import 'dart:math';
import 'dart:async' as asy;
import 'dart:math';
import 'asteroid.dart';

class SpaceShooterGame extends FlameGame
    with PanDetector, KeyboardEvents, HasCollidables {
  late Player player;
  late Asteroid asteroid;
  late Timer timer;
  late TextComponent scoreText;
  late TextComponent timerText;
  late asy.Timer starsTimer;
  late asy.Timer asteroidTimer;
  late asy.Timer gameTimer;

  int score = 0;
  int gameTime = 10;

  Vector2 viewportResolution = Vector2(
    1920,
    1080,
  );


  @override
  Future<void> onLoad() async {
    await super.onLoad();
    document.addEventListener("visibilitychange", onVisibilityChange);
    camera.viewport = FixedResolutionViewport(viewportResolution);
    camera.setRelativeOffset(Anchor.topLeft);
    camera.speed = 1;

    add(ScreenCollidable());
    player = Player();





    // add score text on top
    final style = TextStyle(color: BasicPalette.white.color, fontSize: 30);
    final regular = TextPaint(style: style);
    scoreText = TextComponent(text: 'Score: $score', textRenderer: regular)
      ..anchor = Anchor.topCenter
      ..x = 600 / 2
      ..y = 32.0;
    add(scoreText);

    // add timer text on top

    timerText = TextComponent(text: 'Timer: $gameTime', textRenderer: regular)
      ..anchor = Anchor.topRight
      ..x = viewportResolution.x - 50
      ..y = 32.0;
    add(timerText);
    startGame();
  }

  void endGame() {
    player.removeFromParent();
    asteroidTimer.cancel();
    gameTimer.cancel();
  }

  void pauseGame() {
      player.removeFromParent();
      asteroidTimer.cancel();
      gameTimer.cancel();
      starsTimer.cancel();
  }

  void resumeGame() {
    starsTimer =
        asy.Timer.periodic(const Duration(milliseconds: 100), (timer) {
          add(ParticleComponent(
            AcceleratedParticle(
              lifespan: 1.0,
              // Will fire off in the center of game canvas
              position:
              Vector2(Random().nextInt(viewportResolution.x.round()).toDouble(), 0),
              // With random initial speed of Vector2(-100..100, 0..-100)
              speed: Vector2(0, viewportResolution.length),
              // Accelerating downwards, simulating "gravity"
              // speed: Vector2(0, 100),
              child: CircleParticle(
                radius: 2.0,
                paint: Paint()
                  ..color = Colors.white,
              ),
            ),
          ));
        });
    asteroidTimer =
        asy.Timer.periodic(const Duration(milliseconds: 2000), (timer) {
          asteroid = Asteroid();
          add(asteroid);
        });
    gameTimer =
        asy.Timer.periodic(const Duration(milliseconds: 1000), (timer) {
          gameTime -= 1;
        });
  }

  void startGame() {
    gameTime = 10;
    add(player);
    resumeGame();
  }

  @override
  void update(double dt) {
    super.update(dt);
    scoreText.text = 'Score: $score';
    timerText.text = 'Timer: $gameTime';
    if (gameTime == 0) {
     endGame();
    }

  }

  @override
  KeyEventResult onKeyEvent(RawKeyEvent event,
      Set<LogicalKeyboardKey> keysPressed,) {
    final isSpace = keysPressed.contains(LogicalKeyboardKey.space);
    final isArrowLeft = keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isArrowRight = keysPressed.contains(LogicalKeyboardKey.arrowRight);

    if (isSpace) {
      // spaceship shoots!
      Shoot shoot = Shoot();
      add(shoot);
      return KeyEventResult.handled;
    }
    if (isArrowRight) {
      player.position.x += 30;
      return KeyEventResult.handled;
    }
    if (isArrowLeft) {
      player.position.x -= 30;
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
      // resume the engine
          resumeEngine();
          print('resume');
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
        print('pause');
        pauseEngine();
        break;
    }
    super.lifecycleStateChange(state);
  }

  void onVisibilityChange(Event e) {
    // do something
    if (document.visibilityState == 'visible') {
     print('foreground');
     resumeEngine();
     resumeGame();
    } else {
      print('background');
      pauseEngine();
      pauseGame();
    }
  }

}
