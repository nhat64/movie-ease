import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/presentation/module/popcorn/popcorn_controller.dart';
import 'package:flutter/material.dart';

class PopcornPage extends BaseScreen<PopcornController> {
  const PopcornPage({super.key});

  @override
  Color? get screenBackgroundColor => Colors.black;

  @override
  Widget buildScreen(BuildContext context) {
    return const Center(
      child: Text('Popcorn Page'),
    );
  }
}
