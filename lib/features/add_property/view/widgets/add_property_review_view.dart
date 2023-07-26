import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

class AddPropertyReviewView extends StatelessWidget {
  const AddPropertyReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: HsDimens.spacing16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: HsDimens.spacing24),
            Text(
              HatSpaceStrings.current.preview,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: HsDimens.spacing20),
            const _PropertyImgsCarousel(
              photos: [
                'https://www.bhg.com/thmb/H9VV9JNnKl-H1faFXnPlQfNprYw=/1799x0/filters:no_upscale():strip_icc()/white-modern-house-curved-patio-archway-c0a4a3b3-aa51b24d14d0464ea15d36e05aa85ac9.jpg',
                'https://www.bhg.com/thmb/H9VV9JNnKl-H1faFXnPlQfNprYw=/1799x0/filters:no_upscale():strip_icc()/white-modern-house-curved-patio-archway-c0a4a3b3-aa51b24d14d0464ea15d36e05aa85ac9.jpg'
              ],
            ),
            const SizedBox(height: HsDimens.spacing20),
            Row(
              children: [
                Expanded(
                    child: Text('House',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: HSColor.green06))),
                const SizedBox(width: HsDimens.spacing12),
                RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                        text: HatSpaceStrings.current.availableDateColon,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: HSColor.neutral6),
                        children: [
                          TextSpan(
                            text: HatSpaceStrings.current
                                .dateFormatter(DateTime(2023, 6, 6)),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: HSColor.neutral8,
                                ),
                          )
                        ])),
              ],
            ),
            const SizedBox(height: HsDimens.spacing4),
            Text(
              'Single room for rent in Bankstown',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: HsDimens.spacing4),
            Text('Gateway, Island',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: HSColor.neutral6)),
            const SizedBox(height: HsDimens.spacing8),
            Row(
              children: [
                _PropertyFeatureView(
                  iconSvgUrl: Assets.icons.bed,
                  quantity: 1,
                ),
                const SizedBox(width: HsDimens.spacing8),
                _PropertyFeatureView(
                  iconSvgUrl: Assets.icons.bath,
                  quantity: 2,
                ),
                const SizedBox(width: HsDimens.spacing8),
                _PropertyFeatureView(
                  iconSvgUrl: Assets.icons.car,
                  quantity: 3,
                ),
                const SizedBox(width: HsDimens.spacing12),
                Expanded(
                    child: RichText(
                        textAlign: TextAlign.right,
                        text: TextSpan(
                            text: HatSpaceStrings.current
                                .currencyFormatter(r'$', 30000),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(fontSize: FontStyleGuide.fontSize18),
                            children: [
                              TextSpan(
                                text: ' ${HatSpaceStrings.current.pw}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontWeight: FontStyleGuide.fwRegular),
                              )
                            ])))
              ],
            ),
            const SizedBox(height: HsDimens.spacing16),
            Row(
              children: [
                const CircleAvatar(
                  radius: HsDimens.spacing20,
                  backgroundImage: NetworkImage(
                      'https://www.bhg.com/thmb/H9VV9JNnKl-H1faFXnPlQfNprYw=/1799x0/filters:no_upscale():strip_icc()/white-modern-house-curved-patio-archway-c0a4a3b3-aa51b24d14d0464ea15d36e05aa85ac9.jpg'),
                ),
                const SizedBox(width: HsDimens.spacing8),
                Expanded(
                  child: Text('Jane Cooper',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: HSColor.neutral6)),
                ),
              ],
            ),
            const SizedBox(height: HsDimens.spacing8),
            Text(
                'This updated cottage has much to offer with:- Polished floorboards in living areas and carpeted bedrooms- New modern kitchen with dishwasher, gas burner stove top and plenty of storage- Dining area- Lounge room- Study/Home office space- 2 Bedrooms- Lovely bathroom- Separate laundry.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: HSColor.neutral7)),
            const SizedBox(height: HsDimens.spacing20),
            const Divider(
              height: HsDimens.size4,
              thickness: HsDimens.size4,
              color: HSColor.neutral2,
            ),
            const SizedBox(height: HsDimens.spacing20),
            Text(HatSpaceStrings.current.location,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontSize: FontStyleGuide.fontSize18)),
            const SizedBox(height: HsDimens.spacing8),
            Text(
                'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: HSColor.neutral7)),
            const SizedBox(height: HsDimens.spacing20),
            const Divider(
              height: HsDimens.size4,
              thickness: HsDimens.size4,
              color: HSColor.neutral2,
            ),
            const SizedBox(height: HsDimens.spacing20),
            Text(HatSpaceStrings.current.propertyFeatures,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontSize: FontStyleGuide.fontSize18)),
            const SizedBox(height: HsDimens.spacing16),
            GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 164 / 36,
                    crossAxisSpacing: HsDimens.spacing15,
                    mainAxisSpacing: HsDimens.spacing12),
                itemCount: Feature.values.length,
                itemBuilder: (_, index) => Row(
                      children: [
                        Container(
                          height: HsDimens.size36,
                          width: HsDimens.size36,
                          padding: const EdgeInsets.all(HsDimens.spacing8),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: HSColor.neutral2),
                          child: SvgPicture.asset(
                              Feature.values[index].iconSvgPath),
                        ),
                        const SizedBox(width: HsDimens.spacing12),
                        Expanded(
                            child: Text(Feature.values[index].displayName,
                                style: Theme.of(context).textTheme.bodyMedium))
                      ],
                    )),
            const SizedBox(height: HsDimens.spacing24),
          ]),
        ),
      ),
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
  const _PropertyImgsCarousel({required this.photos});

  @override
  State<_PropertyImgsCarousel> createState() => __PropertyImgsCarouselState();
}

class __PropertyImgsCarouselState extends State<_PropertyImgsCarousel> {
  final PageController _controller = PageController();
  final ValueNotifier<int> _idxNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _idxNotifier.dispose();
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
                bottom: HsDimens.spacing16,
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
                    ],
                  ),
                )),
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
