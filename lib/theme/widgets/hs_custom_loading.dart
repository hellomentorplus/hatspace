import 'package:flutter/material.dart';
import 'package:hatspace/theme/hs_gradient_circular_progress_bar.dart';
import 'package:hatspace/theme/hs_theme.dart';

class CustomLoading extends StatefulWidget {
  final Duration duration;
  final StrokeCap strokeCap;
  final double radius;
  final double strokeWidth;
  final List<Color> gradientColors;

  const CustomLoading(
      {super.key,
      this.duration = const Duration(seconds: 1, milliseconds: 500),
      this.strokeCap = StrokeCap.round,
      this.radius = 12.0,
      this.strokeWidth = 5.0,
      this.gradientColors = const [
        HSColor.primary,
        HSColor.onPrimary,
      ]});
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
      turns: Tween(begin: 1.0, end: 0.0).animate(controller),
      child: GradientCircularProgressIndicator(
        strokeCap: widget.strokeCap,
        radius: widget.radius,
        gradientColors: widget.gradientColors,
        strokeWidth: widget.strokeWidth,
      ),
    );
  }
}
