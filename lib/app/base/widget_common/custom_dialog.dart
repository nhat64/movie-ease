import 'package:flutter/material.dart';

Future<T?> showCustomDialog<T>({
  required BuildContext context,
  required Widget child,
  bool barrierDismissible = true,
  Color? barrierColor,
  Color backgroundColor = Colors.white,
}) {
  return showDialog<T>(
    context: context,
    builder: (context) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: backgroundColor,
          ),
          clipBehavior: Clip.antiAlias,
          child: child,
        ),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
  );
}
