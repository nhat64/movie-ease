import 'package:flutter/material.dart';

class ColoredIcon extends StatelessWidget {
  final Widget child;
  final Color color;
  final double? width;
  final double? height;

  const ColoredIcon({
    super.key,
    required this.color,
    required this.child,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        color,
        BlendMode.srcIn,
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}
