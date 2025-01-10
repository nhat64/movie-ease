import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/app/base/widget_common/call_api_widget.dart';
import 'package:base_flutter/presentation/module/initial/initial_controller.dart';
import 'package:flutter/material.dart';

class InitialPage extends BaseScreen<InitialController> {
  const InitialPage({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        color: Colors.black,
        child: const Center(
          child: CicularLoadingWidget(),
        ),
      ),
    );
  }
}
