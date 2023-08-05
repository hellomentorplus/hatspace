import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

class HsPropertyImagesCarousel extends StatefulWidget {
  final List<String> photos;
  final String? ownerName;
  final String? ownerAvatar;
  final DateTime? availableDate;
  final bool? isFavorited;
  final bool ownerAndDateOverlay;
  final double aspectRatio;

  const HsPropertyImagesCarousel(
      {required this.photos,
      this.availableDate,
      this.isFavorited,
      this.ownerName,
      this.ownerAvatar,
      this.ownerAndDateOverlay = true,
      this.aspectRatio = 343 / 220,
      super.key});

  @override
  State<HsPropertyImagesCarousel> createState() =>
      _HsPropertyImagesCarouselState();
}

class _HsPropertyImagesCarouselState extends State<HsPropertyImagesCarousel> {
  final PageController _controller = PageController();
  final ValueNotifier<int> _idxNotifier = ValueNotifier<int>(0);
  late final ValueNotifier<bool?> _favorited =
      ValueNotifier<bool?>(widget.isFavorited);

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
      aspectRatio: widget.aspectRatio,
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
                        image: CachedNetworkImageProvider(
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
                      if (widget.ownerAndDateOverlay)
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
                              if (widget.availableDate != null)
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
                                                    widget.availableDate!),
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
                child: ValueListenableBuilder<bool?>(
                  valueListenable: _favorited,
                  builder: (_, favorited, __) {
                    return favorited == null
                        ? const SizedBox()
                        : GestureDetector(
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
