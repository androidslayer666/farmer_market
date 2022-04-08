import 'package:flutter/material.dart';

class RadiantGradientMask extends StatelessWidget {
  const RadiantGradientMask(
      {Key? key,
      required this.child,
      required this.first,
      required this.second})
      : super(key: key);

  final Widget child;
  final Color first;
  final Color second;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [first, second],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
