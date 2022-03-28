import 'dart:async';

import 'package:flutter/material.dart';

class Animator extends StatefulWidget {
  final Widget child;
  final Duration time;

  // ignore: use_key_in_widget_constructors
  const Animator(this.child, this.time);

  @override
  _AnimatorState createState() => _AnimatorState();
}

class _AnimatorState extends State<Animator> with TickerProviderStateMixin {
  late Timer timer;
  late AnimationController animationController = AnimationController(
    vsync: this,
  );
  late Animation animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 290),
      vsync: this,
    );
    timer = Timer(widget.time, animationController.forward);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation:
          CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
      child: widget.child,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: CurvedAnimation(
                  parent: animationController, curve: Curves.easeInOut)
              .value,
          child: Transform.translate(
            offset: Offset(
                0.0,
                (1 -
                        CurvedAnimation(
                                parent: animationController,
                                curve: Curves.easeInOut)
                            .value) *
                    20),
            child: child,
          ),
        );
      },
    );
  }
}

class WidgetAnimator extends StatelessWidget {
  final Widget child;

  // ignore: use_key_in_widget_constructors
  const WidgetAnimator(this.child);

  @override
  Widget build(BuildContext context) {
    Timer? timer;
    Duration duration = const Duration();

    Duration wait() {
      if (timer == null || !timer!.isActive) {
        timer = Timer(const Duration(microseconds: 120), () {
          duration = const Duration();
        });
      }
      duration += const Duration(milliseconds: 100);
      return duration;
    }

    return Animator(child, wait());
  }
}
