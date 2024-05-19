import 'package:airplane/core/utils/app_constant.dart';
import 'package:flutter/material.dart';

class CustomTimer extends StatelessWidget {
  final Duration duration;
  const CustomTimer({Key? key, required this.duration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Duration>(
        duration: duration,
        tween: Tween(begin: duration, end: Duration.zero),
        onEnd: () {
          AppConstant.showCustomSnakeBar(context, "Flight End", true);
        },
        builder: (BuildContext context, Duration value, Widget? child) {
          final minutes = value.inMinutes;
          final seconds = value.inSeconds % 60;
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text('$minutes:$seconds',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22)));
        });
  }
}
