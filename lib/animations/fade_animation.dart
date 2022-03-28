import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum AnimationType { opacity, translateX }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation(this.delay, this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AnimationType>()
      ..add(AnimationType.opacity, Tween(begin: 0.0, end: 1.0),
          const Duration(milliseconds: 500))
      ..add(AnimationType.translateX, Tween(begin: -130.0, end: 0.0),
          const Duration(milliseconds: 500), Curves.easeOut);

    return CustomAnimation<MultiTweenValues<AnimationType>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, animation) => Opacity(
        opacity: animation.get(AnimationType.opacity),
        child: Transform.translate(
            offset: Offset(0, animation.get(AnimationType.translateX)),
            child: child),
      ),
    );
  }
}
