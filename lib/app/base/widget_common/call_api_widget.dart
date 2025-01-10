import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallApiWidget {
  static OverlayEntry? _overlayEntry;

  static Future<dynamic> checkTimeCallApi({required Future<dynamic> api, required BuildContext context, child, isShowLoading = true}) async {
    if (isShowLoading) {
      createHighlightOverlay(context: context, child: child);
    }
    Stopwatch stopwatch = Stopwatch()..start();
    final result = await api;
    stopwatch.stop();
    if (stopwatch.elapsedMilliseconds < 200) {
      await Future.delayed(const Duration(milliseconds: 300));
    }
    if (isShowLoading) {
      removeHighlightOverlay();
    }
    return result;
  }

  static showLoading({required BuildContext context, Widget? child}) {
    createHighlightOverlay(context: Get.context!, child: child);
  }

  static hideLoading() {
    removeHighlightOverlay();
  }

  static removeHighlightOverlay() {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
  }

  static createHighlightOverlay({
    required BuildContext context,
    Widget? child,
  }) {
    removeHighlightOverlay();
    OverlayState overlayState = Overlay.of(context);

    assert(_overlayEntry == null);

    if (_overlayEntry != null) {
      return;
    }

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return AnimatedPositioned(
          width: Get.width,
          height: Get.height,
          duration: Duration.zero,
          child: GestureDetector(
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: child ?? const CicularLoadingWidget(),
              ),
            ),
            onTap: () {},
          ),
        );
      },
    );

    overlayState.insert(_overlayEntry!);
  }
}

class CicularLoadingWidget extends StatelessWidget {
  const CicularLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 40,
      height: 40,
      child: CircularProgressIndicator(
        color: Color(0xFFFCC434),
      ),
    );
  }
}
