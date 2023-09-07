part of '../property_detail_screen.dart';

class PropertyDescriptionView extends StatelessWidget {
  final String description;
  final int? maxLine;

  const PropertyDescriptionView(
      {required this.description, required this.maxLine, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final TextStyle? style = Theme.of(context).textTheme.bodyMedium;

        if (_overflow(constraints.maxWidth, style)) {
          return _LongPropertyDescriptionView(
              description: description, maxLine: maxLine, style: style);
        }

        return Text(
          description,
          textAlign: TextAlign.justify,
          style: style?.copyWith(color: HSColor.neutral7),
        );
      },
    );
  }

  bool _overflow(double maxWidth, TextStyle? style) {
    if (maxLine == null) {
      return false;
    }

    final TextPainter painter = TextPainter(
        text: TextSpan(text: description, style: style),
        textDirection: TextDirection.ltr);

    painter.layout(maxWidth: maxWidth);
    TextSelection selection =
        TextSelection(baseOffset: 0, extentOffset: description.length);
    List<TextBox> boxes = painter.getBoxesForSelection(selection);

    return boxes.length > (maxLine ?? 0);
  }
}

class _LongPropertyDescriptionView extends StatefulWidget {
  final String description;
  final int? maxLine;
  final TextStyle? style;

  const _LongPropertyDescriptionView(
      {required this.description,
      required this.maxLine,
      required this.style,
      Key? key})
      : super(key: key);

  @override
  State<_LongPropertyDescriptionView> createState() =>
      _LongPropertyDescriptionViewState();
}

class _LongPropertyDescriptionViewState
    extends State<_LongPropertyDescriptionView> with TickerProviderStateMixin {
  final Duration _duration = const Duration(milliseconds: 300);
  late final AnimationController _animationController =
      AnimationController(vsync: this)..duration = _duration;

  late final Animation<double> _shortTextFade =
      Tween(begin: 1.0, end: 0.0).animate(_animationController);

  late final Animation<double> _longTextSize =
      Tween(begin: 0.0, end: 1.0).animate(_animationController);

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            SizeTransition(
              sizeFactor: _longTextSize,
              axisAlignment: -1,
              child: Text(
                widget.description,
                textAlign: TextAlign.justify,
                style: (widget.style ?? Theme.of(context).textTheme.bodyMedium)
                    ?.copyWith(color: HSColor.neutral7),
              ),
            ),
            FadeTransition(
              opacity: _shortTextFade,
              child: ColoredBox(
                color: Theme.of(context).colorScheme.background,
                child: Text(
                  widget.description,
                  maxLines: widget.maxLine,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  style:
                      (widget.style ?? Theme.of(context).textTheme.bodyMedium)
                          ?.copyWith(color: HSColor.neutral7),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: HsDimens.spacing8,
        ),
        ShowMoreLabel(
          animationController: _animationController,
          duration: _duration,
        )
      ],
    );
  }
}
