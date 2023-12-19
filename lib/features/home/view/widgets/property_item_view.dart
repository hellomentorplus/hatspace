import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/home/data/property_item_data.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

import 'package:hatspace/theme/widgets/hs_property_images_carousel.dart';
import 'package:hatspace/theme/widgets/hs_room_count_view.dart';

class PropertyItemView extends StatelessWidget {
  final PropertyItemData property;

  const PropertyItemView({required this.property, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goToPropertyDetail(id: property.id);
      },
      child: Column(
        children: [
          HsPropertyImagesCarousel(
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
                            property.priceUnit.displayName,
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
                    RoomListingCountView(
                        bedrooms: property.numberOfBedrooms,
                        bathrooms: property.numberOfBathrooms,
                        cars: property.numberOfParkings),
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
                            color: HSColor.green06,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
