import 'package:flutter/material.dart';

class HsDottedContainer extends StatelessWidget {
  final Widget? child;
  const HsDottedContainer({this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CustomPaint(
    painter: _DottedBorderPainter(
      width: 1,
      color: Colors.grey,
      radius: 8
    ),
    child: child,
  );
}

class _DottedBorderPainter extends CustomPainter {
  final double width;
  final Color color;
  final double radius;

  late final Paint _paint = Paint()
  ..color = color
  ..style = PaintingStyle.stroke
  ..strokeWidth = width;

  late final Paint _eraser = Paint()
  ..blendMode = BlendMode.clear
  ..color = color;

  _DottedBorderPainter({required this.width, required this.color, required this.radius});
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromPoints(Offset.zero, Offset(size.width, size.height)), Radius.circular(radius)), _paint);

    canvas.save();
    for (int i = radius.toInt(); i < size.width - radius; i += 6) {
      // top
      canvas.drawRect(Rect.fromPoints(Offset(i.toDouble(), -1), Offset(i + 3, 1)), _eraser);
      // left
      canvas.drawRect(Rect.fromPoints(Offset(-1, i.toDouble()), Offset(1, i + 3)), _eraser);
      // bottom
      canvas.drawRect(Rect.fromPoints(Offset(i.toDouble(), size.height - 1), Offset(i + 3, size.height + 1)), _eraser);
      // right
      canvas.drawRect(Rect.fromPoints(Offset(size.width, i.toDouble()), Offset(size.width, i + 3)), _eraser);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is! _DottedBorderPainter
        || oldDelegate.color != color
        || oldDelegate.width != width
    || oldDelegate.radius != radius;
  }

}