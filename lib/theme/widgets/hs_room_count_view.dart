import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/hs_theme.dart';

class RoomListingCountView extends StatelessWidget {
  final int bedrooms;
  final int bathrooms;
  final int cars;

  const RoomListingCountView(
      {required this.bedrooms,
      required this.bathrooms,
      required this.cars,
      super.key});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _RoomCounts(iconAsset: Assets.icons.bed, count: bedrooms.toString()),
          const SizedBox(
            width: HsDimens.spacing8,
          ),
          _RoomCounts(
              iconAsset: Assets.icons.bath, count: bathrooms.toString()),
          const SizedBox(
            width: HsDimens.spacing8,
          ),
          _RoomCounts(iconAsset: Assets.icons.car, count: cars.toString())
        ],
      );
}

class _RoomCounts extends StatelessWidget {
  final String iconAsset;
  final String count;
  const _RoomCounts({required this.iconAsset, required this.count});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            iconAsset,
            width: HsDimens.size32,
            height: HsDimens.size32,
          ),
          const SizedBox(
            width: HsDimens.spacing4,
          ),
          Text(
            count,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: HSColor.neutral6),
          )
        ],
      );
}
