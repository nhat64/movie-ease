import 'package:flutter/material.dart';

class TicketWidget extends StatelessWidget {
  const TicketWidget({
    super.key,
    this.contentWidget,
    this.stubWidget,
    required this.width,
    required this.height,
    required this.stubHeight,
    required this.borderRadius,
    required this.notchRadius,
    this.backgroundColor,
    this.duration = const Duration(milliseconds: 100),
    this.onTap,
  });

  final double width;
  final double height;
  final double stubHeight;
  final double borderRadius;
  final double notchRadius;

  final Color? backgroundColor;
  final Duration duration;

  final Widget? contentWidget;
  final Widget? stubWidget;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _TicketClipper(
        borderRadius: borderRadius,
        clipRadius: notchRadius,
        stubHeight: stubHeight,
      ),
      child: CustomPaint(
        foregroundPainter: _TicketPainter(
          stubHeight: stubHeight,
          notchRadius: notchRadius,
          dashLength: 8,
          dashSpacing: 4,
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onTap,
          child: AnimatedContainer(
            duration: duration,
            width: width,
            height: height,
            color: backgroundColor,
            child: Column(
              children: [
                Expanded(
                  child: contentWidget ?? const SizedBox.shrink(),
                ),
                SizedBox(
                  height: stubHeight,
                  child: stubWidget,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TicketPainter extends CustomPainter {
  const _TicketPainter({
    required this.stubHeight,
    required this.notchRadius,
    required this.dashLength,
    required this.dashSpacing,
  });

  final double stubHeight;
  final double notchRadius;
  final double dashLength;
  final double dashSpacing;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final dashWidth = size.width - 2 * notchRadius;
    final numDashes = dashWidth ~/ (dashLength + dashSpacing);
    double dx = notchRadius + (dashWidth - numDashes * dashLength - (numDashes - 1) * dashSpacing) / 2;
    final dy = size.height - stubHeight;

    for (int i = 0; i < numDashes; i++) {
      canvas.drawLine(
        Offset(dx, dy),
        Offset(dx + dashLength, dy),
        paint,
      );
      dx += dashLength + dashSpacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _TicketClipper extends CustomClipper<Path> {
  const _TicketClipper({
    required this.borderRadius,
    required this.clipRadius,
    required this.stubHeight,
  });

  final double borderRadius;
  final double clipRadius;
  final double stubHeight;

  @override
  Path getClip(Size size) {
    // tạo một path hình chữ nhật có radius
    var path = Path();

    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    ));

    // tạo path cho các phần cắt
    final clipCenterY = size.height - stubHeight;

    final clipPath = Path();

    // circle on the left
    clipPath.addOval(Rect.fromCircle(
      center: Offset(0, clipCenterY),
      radius: clipRadius,
    ));

    // circle on the right
    clipPath.addOval(Rect.fromCircle(
      center: Offset(size.width, clipCenterY),
      radius: clipRadius,
    ));

    final ticketPath = Path.combine(
      PathOperation.reverseDifference,
      clipPath,
      path,
    );

    return ticketPath;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
