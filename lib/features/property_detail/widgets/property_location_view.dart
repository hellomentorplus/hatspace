import 'package:flutter/material.dart';

import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

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
