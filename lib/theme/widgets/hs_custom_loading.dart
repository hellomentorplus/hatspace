import 'package:flutter/material.dart';
import 'package:hatspace/theme/hs_gradient_circular_progress_bar.dart';

class CustomLoading extends StatefulWidget {
  final Duration duration;
  final StrokeCap strokeCap;
  final double radius;
  final double strokeWidth;
  final List<Color> gradientColors;

  const CustomLoading(
      {super.key,
      required this.duration,
      required this.strokeCap,
      required this.radius,
      required this.strokeWidth,
      required this.gradientColors});
  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    controller.repeat();
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(controller),
      child: GradientCircularProgressIndicator(
        strokeCap: widget.strokeCap,
        radius: widget.radius,
        gradientColors: widget.gradientColors,
        strokeWidth: widget.strokeWidth,
      ),
    );
  }
}
