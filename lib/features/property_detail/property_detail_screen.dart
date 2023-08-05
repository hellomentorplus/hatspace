import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_property_images_carousel.dart';
import 'package:hatspace/theme/widgets/hs_room_count_view.dart';
import 'package:hatspace/data/property_data.dart';

class PropertyDetailScreen extends StatelessWidget {
  final String id;
  const PropertyDetailScreen({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  const HsPropertyImagesCarousel(
                    photos: [
                      'https://photos.zillowstatic.com/fp/98a9bfb7913156ca8664ff7da82ec71d-p_e.jpg',
                      'https://photos.zillowstatic.com/fp/1b490f938bdb2fef0e344d9785995157-cc_ft_1536.jpg'
                    ],
                    ownerAndDateOverlay: false,
                    aspectRatio: 375 / 280,
                  ),
                  SafeArea(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: HsDimens.spacing16,
                        horizontal: HsDimens.spacing8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => context.pop(),
                          child: SvgPicture.asset(
                            Assets.icons.backCircle,
                            width: HsDimens.size32,
                            height: HsDimens.size32,
                          ),
                        ),
                        SvgPicture.asset(
                          Assets.icons.favoriteCircle,
                          width: HsDimens.size32,
                          height: HsDimens.size32,
                        )
                      ],
                    ),
                  )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: HsDimens.spacing16,
                    left: HsDimens.spacing16,
                    right: HsDimens.spacing16,
                    bottom: HsDimens.spacing4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'House',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset(
                          Assets.icons.eye,
                          width: HsDimens.size24,
                          height: HsDimens.size24,
                        ),
                        const SizedBox(
                          width: HsDimens.size4,
                        ),
                        Text(
                          '40 views today',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: HSColor.neutral6),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: HsDimens.spacing16,
                    right: HsDimens.spacing16,
                    bottom: HsDimens.spacing4),
                child: Text(
                  'Single room for rent in Bankstown',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(color: HSColor.neutral9),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: HsDimens.spacing16,
                    right: HsDimens.spacing16,
                    bottom: HsDimens.spacing8),
                child: Text(
                  'Gateway, Island',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: HSColor.neutral6),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                    left: HsDimens.spacing16,
                    right: HsDimens.spacing16,
                    bottom: HsDimens.spacing16),
                child: RoomListingCountView(
                  bedrooms: 2,
                  bathrooms: 2,
                  cars: 2,
                ),
              ),
              // owner info
              Padding(
                padding: const EdgeInsets.only(
                    left: HsDimens.spacing16,
                    right: HsDimens.spacing16,
                    bottom: HsDimens.spacing16),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(HsDimens.radius24),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80',
                        width: HsDimens.size24,
                        height: HsDimens.size24,
                      ),
                    ),
                    const SizedBox(
                      width: HsDimens.spacing8,
                    ),
                    Text(
                      'Jane Cooper',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: HSColor.neutral6),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                    left: HsDimens.spacing16,
                    right: HsDimens.spacing16,
                    bottom: HsDimens.spacing8),
                child: _PropertyDescription(
                  description:
                      'This updated cottage has much to offer with:- Polished floorboards in living areas and carpeted bedrooms- New modern kitchen with dishwasher, gas burner stove top and plenty of storage- Dining area- Lounge room- Study/Home office space- 2 Bedrooms- Lovely bathroom- Separate laundry and toilet- Second toilet outside- Split system heating and cooling only- Undercover entertainment area- Spacious low maintenance backyard- Rear lane access to lock-up garage/shed- Large front verandah- 500m to Dean StreetLocated close to schools, parks and all central Albury has to offer!',
                  maxLine: 3,
                ),
              ),
              const Divider(
                height: HsDimens.size4,
                thickness: HsDimens.size4,
                color: HSColor.neutral2,
              ),
              const PropertyLocationView(
                locationDetail:
                    'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim',
              ),
              const Divider(
                height: HsDimens.size4,
                thickness: HsDimens.size4,
                color: HSColor.neutral2,
              ),
              const PropertyFeatures(features: Feature.values)
            ],
          ),
        ),
      );
}

class _PropertyDescription extends StatelessWidget {
  final String description;
  final int? maxLine;
  const _PropertyDescription(
      {required this.description, required this.maxLine, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: HSColor.neutral7),
    );
  }
}

class PropertyLocationView extends StatelessWidget {
  final String locationDetail;
  const PropertyLocationView({required this.locationDetail, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(HsDimens.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              HatSpaceStrings.current.location,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 18, color: HSColor.neutral9),
            ),
            const SizedBox(
              height: HsDimens.spacing8,
            ),
            Text(
              locationDetail,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: HSColor.neutral7),
            )
          ],
        ),
      );
}

class PropertyFeatures extends StatelessWidget {
  final List<Feature> features;
  const PropertyFeatures({required this.features, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
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
            LayoutGrid(
              columnSizes: [1.fr, 1.fr],
              rowSizes: List.filled(features.length, auto),
              gridFit: GridFit.passthrough,
              rowGap: HsDimens.spacing12,
              columnGap: HsDimens.spacing16,
              children: features
                  .map((e) => Row(
                        children: [
                          Container(
                            decoration: const ShapeDecoration(
                              color: HSColor.neutral2,
                              shape: CircleBorder(),
                            ),
                            width: HsDimens.size36,
                            height: HsDimens.size36,
                            padding: const EdgeInsets.all(HsDimens.spacing8),
                            child: SvgPicture.asset(e.iconSvgPath),
                          ),
                          const SizedBox(
                            width: HsDimens.spacing12,
                          ),
                          Text(
                            e.displayName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: HSColor.neutral9),
                          )
                        ],
                      ))
                  .toList(),
            )
          ],
        ),
      );
}
