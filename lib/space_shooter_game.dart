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
import 'package:flutter_game/star.dart';
import 'dart:math';
import 'dart:async' as asy;
import 'dart:math';
import 'asteroid.dart';

class SpaceShooterGame extends FlameGame
    with PanDetector, KeyboardEvents, HasCollidables {
  late Player player;
  late Asteroid asteroid;
  late Timer timer;
  int score = 0;

  late int asteroidCount = 0;

  Vector2 viewportResolution = Vector2(
    1920,
    1080,
  );
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    camera.viewport = FixedResolutionViewport(viewportResolution);
    camera.setRelativeOffset(Anchor.topLeft);
    camera.speed = 1;

    player = Player();
    add(player);
    add(ScreenCollidable());

    final rnd = Random();
    Vector2 randomVector2() =>
        (Vector2.random(rnd) - Vector2.random(rnd)) * 100;
    final asy.Timer timer_stars =
    asy.Timer.periodic(const Duration(milliseconds: 100), (timer) {
      add(ParticleComponent(
        AcceleratedParticle(
          // Will fire off in the center of game canvas
          position:
          Vector2(Random().nextInt(viewportResolution.x.round()) as double, 0),
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

    final asy.Timer timer =
    asy.Timer.periodic(const Duration(milliseconds: 2000), (timer) {
      asteroid = Asteroid();
      add(asteroid);
    });

    // add score text on top
    final style = TextStyle(color: BasicPalette.white.color, fontSize: 14);
    final regular = TextPaint(style: style);
    add(TextComponent(text: 'Score: $score', textRenderer: regular)
      ..anchor = Anchor.topCenter
      ..x = 600 / 2
      ..y = 32.0);
  }

  /*@override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.game);
  }
  */

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
}
