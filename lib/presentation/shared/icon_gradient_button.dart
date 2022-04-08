import 'package:flutter/material.dart';

import 'gradient_mask.dart';

class IconGradientButton extends StatelessWidget {
  const IconGradientButton(
      {Key? key,
      required this.color,
      required this.iconData,
      required this.onPressed, this.size = 30})
      : super(key: key);

  final Color color;
  final IconData iconData;
  final Function onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return RadiantGradientMask(
      first: color,
      second: Colors.white,
      child: IconButton(
        iconSize: size,
        color: color,
          icon: Icon(
            iconData,
            color: color.withOpacity(0.8),
          ),
          onPressed: () {
            onPressed();
          }),
    );
  }
}
