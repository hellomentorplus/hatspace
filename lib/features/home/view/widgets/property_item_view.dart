import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/home/data/property_item_data.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

class PropertyItemView extends StatelessWidget {
  final PropertyItemData property;
  const PropertyItemView({required this.property, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PropertyImgsCarousel(
          photos: property.photos,
          ownerName: property.ownerName,
          ownerAvatar: property.ownerAvatar,
          availableDate: property.availableDate,
          isFavorited: property.isFavorited,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: HsDimens.spacing8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      Text(
                        HatSpaceStrings.current.currencyFormatter(
                            property.currency.symbol, property.price),
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(width: HsDimens.spacing4),
                      Padding(
                        padding: const EdgeInsets.only(top: HsDimens.radius8),
                        child: Text(
                          HatSpaceStrings.current.pw,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: HSColor.neutral6),
                        ),
                      )
                    ],
                  )),
                  Padding(
                    padding: const EdgeInsets.only(top: HsDimens.radius8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          Assets.icons.eye,
                          colorFilter: const ColorFilter.mode(
                              HSColor.neutral6, BlendMode.srcIn),
                        ),
                        const SizedBox(
                          width: HsDimens.spacing4,
                        ),
                        Text(
                          HatSpaceStrings.current
                              .viewsToday(property.numberOfViewsToday),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: HSColor.neutral6),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: HsDimens.spacing4,
              ),
              Text(
                property.state,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: HSColor.neutral6),
              ),
              const SizedBox(
                height: HsDimens.spacing8,
              ),
              Row(
                children: [
                  _PropertyFeatureView(
                    iconSvgUrl: Assets.icons.bed,
                    quantity: property.numberOfBedrooms,
                  ),
                  const SizedBox(
                    width: HsDimens.spacing8,
                  ),
                  _PropertyFeatureView(
                    iconSvgUrl: Assets.icons.bath,
                    quantity: property.numberOfBathrooms,
                  ),
                  const SizedBox(
                    width: HsDimens.spacing8,
                  ),
                  _PropertyFeatureView(
                    iconSvgUrl: Assets.icons.car,
                    quantity: property.numberOfParkings,
                  ),
                  Container(
                    height: HsDimens.spacing4,
                    width: HsDimens.spacing4,
                    margin: const EdgeInsets.symmetric(
                        horizontal: HsDimens.spacing12),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: HSColor.neutral4),
                  ),
                  Expanded(
                    child: Text(
                      property.type.displayName,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: HSColor.green06, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class _PropertyFeatureView extends StatelessWidget {
  final String iconSvgUrl;
  final int quantity;
  const _PropertyFeatureView(
      {required this.iconSvgUrl, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(iconSvgUrl),
        const SizedBox(
          width: HsDimens.spacing4,
        ),
        Text(
          quantity.toString(),
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: HSColor.neutral6),
        )
      ],
    );
  }
}

class _PropertyImgsCarousel extends StatefulWidget {
  final List<String> photos;
  final String? ownerName;
  final String? ownerAvatar;
  final DateTime availableDate;
  final bool isFavorited;
  const _PropertyImgsCarousel(
      {required this.photos,
      required this.availableDate,
      required this.isFavorited,
      this.ownerName,
      this.ownerAvatar});

  @override
  State<_PropertyImgsCarousel> createState() => __PropertyImgsCarouselState();
}

class __PropertyImgsCarouselState extends State<_PropertyImgsCarousel> {
  final PageController _controller = PageController();
  final ValueNotifier<int> _idxNotifier = ValueNotifier<int>(0);
  late final ValueNotifier<bool> _favorited =
      ValueNotifier<bool>(widget.isFavorited);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _idxNotifier.dispose();
    _favorited.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 343 / 220,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(HsDimens.radius8),
        ),
        child: Stack(
          children: [
            PageView.builder(
              itemCount: widget.photos.length,
              onPageChanged: (index) => _idxNotifier.value = index,
              controller: _controller,
              itemBuilder: (_, int idx) => Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(HsDimens.radius8),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          widget.photos[idx],
                        ))),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: HsDimens.radius2,
                      right: HsDimens.radius2,
                      bottom: HsDimens.radius2),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widget.photos
                            .map((photo) => ValueListenableBuilder<int>(
                                valueListenable: _idxNotifier,
                                builder: (_, selectedIndex, __) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        right: widget.photos.indexOf(photo) ==
                                                widget.photos.length - 1
                                            ? 0
                                            : HsDimens.spacing4),
                                    child: _DotIndicator(
                                      isSelected: selectedIndex ==
                                          widget.photos.indexOf(photo),
                                    ),
                                  );
                                }))
                            .toList(),
                      ),
                      const SizedBox(
                        height: HsDimens.spacing8,
                      ),
                      Container(
                        padding: const EdgeInsets.all(HsDimens.spacing4),
                        decoration: BoxDecoration(
                            color: HSColor.background.withOpacity(0.9),
                            borderRadius:
                                BorderRadius.circular(HsDimens.radius7)),
                        child: Row(
                          children: [
                            if (widget.ownerAvatar != null &&
                                widget.ownerAvatar!.isNotEmpty) ...[
                              CircleAvatar(
                                radius: HsDimens.spacing20,
                                backgroundImage:
                                    NetworkImage(widget.ownerAvatar!),
                              ),
                              const SizedBox(
                                width: HsDimens.spacing4,
                              ),
                            ] else ...[
                              /// TODO : Handle when user doesn't has avatar
                            ],
                            Expanded(
                              child: Text(
                                widget.ownerName ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: HSColor.neutral6,
                                        fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(width: 12),
                            RichText(
                                textAlign: TextAlign.end,
                                text: TextSpan(
                                    text: HatSpaceStrings
                                        .current.availableDateColon,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: HSColor.neutral6),
                                    children: [
                                      TextSpan(
                                        text: HatSpaceStrings.current
                                            .dateFormatter(
                                                widget.availableDate),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: HSColor.neutral8,
                                            ),
                                      )
                                    ])),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            Positioned(
                top: HsDimens.spacing8,
                right: HsDimens.spacing8,
                child: ValueListenableBuilder<bool>(
                  valueListenable: _favorited,
                  builder: (_, favorited, __) {
                    return GestureDetector(
                      onTap: () => _favorited.value = !favorited,
                      child: SvgPicture.asset(
                        favorited
                            ? Assets.icons.favoriteActive
                            : Assets.icons.favoriteUnactive,
                      ),
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}

class _DotIndicator extends StatelessWidget {
  final bool isSelected;
  const _DotIndicator({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: HsDimens.size6,
      width: HsDimens.size6,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected
              ? HSColor.neutral1
              : HSColor.neutral1.withOpacity(0.5)),
    );
  }
}
