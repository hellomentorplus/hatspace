part of '../property_detail_screen.dart';

class PropertyDescriptionView extends StatefulWidget {
  final String description;
  final int? maxLine;

  const PropertyDescriptionView(
      {required this.description, required this.maxLine, Key? key})
      : super(key: key);

  @override
  State<PropertyDescriptionView> createState() =>
      _PropertyDescriptionViewState();
}

class _PropertyDescriptionViewState extends State<PropertyDescriptionView>
    with TickerProviderStateMixin {
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
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
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
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
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
