part of '../property_detail_screen.dart';

class PropertyFeaturesView extends StatefulWidget {
  final List<Feature> features;
  const PropertyFeaturesView({required this.features, super.key});

  @override
  State<PropertyFeaturesView> createState() => _PropertyFeaturesViewState();
}

class _PropertyFeaturesViewState extends State<PropertyFeaturesView>
    with SingleTickerProviderStateMixin {
  final Duration _duration = const Duration(milliseconds: 300);
  late final AnimationController _animationController =
      AnimationController(vsync: this)..duration = _duration;

  final ValueNotifier<bool> _isExpanded = ValueNotifier(false);

  late final Animation<double> _sizeFactor = Tween(
    begin: widget.features.length > 4
        ? 2 / (widget.features.length / 2).ceil()
        : 1.0,
    end: 1.0,
  ).animate(_animationController);

  @override
  Widget build(BuildContext context) {
    return widget.features.isEmpty
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.all(HsDimens.spacing16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  HatSpaceStrings.current.propertyFeatures,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 18, color: HSColor.neutral9),
                ),
                const SizedBox(
                  height: HsDimens.spacing16,
                ),
                SizeTransition(
                  axisAlignment: -1,
                  sizeFactor: _sizeFactor,
                  child: LayoutGrid(
                    columnSizes: [1.fr, 1.fr],
                    rowSizes: List.filled(
                        max((widget.features.length / 2).ceil(), 1), auto),
                    gridFit: GridFit.passthrough,
                    rowGap: HsDimens.spacing12,
                    columnGap: HsDimens.spacing16,
                    children: widget.features
                        .map((e) => Row(
                              children: [
                                Container(
                                  decoration: const ShapeDecoration(
                                    color: HSColor.neutral2,
                                    shape: CircleBorder(),
                                  ),
                                  width: HsDimens.size36,
                                  height: HsDimens.size36,
                                  padding:
                                      const EdgeInsets.all(HsDimens.spacing8),
                                  child: SvgPicture.asset(e.iconSvgPath),
                                ),
                                const SizedBox(
                                  width: HsDimens.spacing12,
                                ),
                                Expanded(
                                    child: Text(
                                  e.displayName,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: HSColor.neutral9),
                                  overflow: TextOverflow.ellipsis,
                                ))
                              ],
                            ))
                        .toList(),
                  ),
                ),
                if (widget.features.length > 4)
                  ShowMoreLabel(
                    animationController: _animationController,
                    duration: _duration,
                    counter: widget.features.length - 4,
                  ),
              ],
            ),
          );
  }

  @override
  void dispose() {
    _isExpanded.dispose();
    super.dispose();
  }
}
