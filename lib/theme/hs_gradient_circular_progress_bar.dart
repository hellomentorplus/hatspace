import 'dart:math';
import 'package:flutter/material.dart';

class GradientCircularProgressIndicator extends StatelessWidget {
  final double radius;
  final List<Color> gradientColors;
  final double strokeWidth;
  final StrokeCap strokeCap;

  const GradientCircularProgressIndicator({
    super.key,
    required this.radius,
    required this.gradientColors,
    required this.strokeCap,
    required this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.fromRadius(radius),
      painter: GradientCircularProgressPainter(
          radius: radius,
          gradientColors: gradientColors,
          strokeWidth: strokeWidth,
          strokeCap: strokeCap),
    );
  }
}

class GradientCircularProgressPainter extends CustomPainter {
  GradientCircularProgressPainter(
      {required this.radius,
      required this.gradientColors,
      required this.strokeWidth,
      required this.strokeCap});
  final double radius;
  final List<Color> gradientColors;
  final double strokeWidth;
  final StrokeCap strokeCap;
  @override
  void paint(Canvas canvas, Size size) {
    size = Size.fromRadius(radius);
    double offset = strokeWidth / 2;
    Rect rect = Offset(offset, offset) &
        Size(size.width - strokeWidth, size.height - strokeWidth);
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = strokeCap;
    paint.shader =
        SweepGradient(colors: gradientColors, startAngle: 1, endAngle: pi * 2)
            .createShader(rect);
    canvas.drawArc(rect, 0.3, pi * 1.8, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
