part of '../property_detail_screen.dart';

class ShowMoreLabel extends StatefulWidget {
  final AnimationController animationController;
  final Duration duration;

  const ShowMoreLabel(
      {required this.animationController, required this.duration, Key? key})
      : super(key: key);

  @override
  State<ShowMoreLabel> createState() => _ShowMoreLabelState();
}

class _ShowMoreLabelState extends State<ShowMoreLabel>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<String> _label =
      ValueNotifier(HatSpaceStrings.current.showMore);

  late final Animation<double> _chevron =
      Tween<double>(begin: 0.5, end: 1.0).animate(widget.animationController);

  @override
  void initState() {
    super.initState();

    widget.animationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        _label.value = HatSpaceStrings.current.showMore;
      } else {
        _label.value = HatSpaceStrings.current.showLess;
      }
    });
  }

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          if (widget.animationController.status == AnimationStatus.completed) {
            widget.animationController.reverse();
          } else {
            widget.animationController.forward();
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: HsDimens.spacing8),
          child: Row(
            children: [
              ValueListenableBuilder<String>(
                valueListenable: _label,
                builder: (context, text, child) => AnimatedSwitcher(
                  duration: widget.duration,
                  child: Text(
                    text,
                    key: ValueKey<String>(text),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
              RotationTransition(
                turns: _chevron,
                child: SvgPicture.asset(
                  Assets.icons.chervonDown,
                  width: HsDimens.size20,
                  height: HsDimens.size20,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                ),
              )
            ],
          ),
        ),
      );
}
