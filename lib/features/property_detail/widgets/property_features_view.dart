import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_svg/svg.dart';

import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

class PropertyFeaturesView extends StatelessWidget {
  final List<Feature> features;
  const PropertyFeaturesView({required this.features, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => features.isEmpty
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
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ))
                    .toList(),
              )
            ],
          ),
        );
}
