import 'package:flutter/material.dart';

class ScaleButton extends StatefulWidget {
  final Function() onTap;
  final Widget child;
  final Duration duration;
  const ScaleButton({super.key, required this.onTap, required this.child, this.duration = const Duration(milliseconds: 100)});

  @override
  State<ScaleButton> createState() {
    return _ScaleButtonState();
  }
}

class _ScaleButtonState extends State<ScaleButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse().then(
          (value) {
            widget.onTap.call();
          },
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(),
      child: ScaleTransition(
        scale: _animation,
        child: Container(
          color: Colors.transparent,
          child: IgnorePointer(
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
