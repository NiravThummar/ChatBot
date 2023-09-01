import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;
  FadeAnimation({required this.delay, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    // final tween=Multi([
    //   Track("opacity").add(Duration(milliseconds: 500),Tween(begin: 0.0,end: 1.0)),
    //   Track("translately").add(Duration(milliseconds: 500),Tween(begin: -30.0,end: 0.0),curve:Curves.easeOut),

    // ])
    // return PlayAnimationBuilder(

    // );
    final tween = MovieTween()
      ..tween('opacity', Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 500))
          .thenTween('y', Tween(begin: -30.0, end: 0.0),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut);

    return PlayAnimationBuilder<Movie>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, value, child) => Opacity(
        opacity: value.get("opacity"),
        child: Transform.translate(
            offset: Offset(0, value.get("y")), child: child),
      ),
    );
  }
}
