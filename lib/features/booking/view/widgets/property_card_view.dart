import 'package:flutter/material.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

class PropertyCardView extends StatelessWidget {
  final String imageUrl;
  final PropertyTypes type;
  final String title;
  final String state;
  final double price;
  final double imageSize;
  final String symbol;
  const PropertyCardView(
      {required this.imageUrl,
      required this.type,
      required this.title,
      required this.state,
      required this.price,
      required this.symbol, super.key,
      this.imageSize = HsDimens.size110});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: imageSize,
          height: imageSize,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(HsDimens.radius8),
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(imageUrl))),
        ),
        const SizedBox(width: HsDimens.spacing16),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(type.displayName,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500, color: HSColor.green06)),
            const SizedBox(height: HsDimens.spacing4),
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontStyleGuide.fwBold)),
            const SizedBox(height: HsDimens.spacing4),
            Text(state, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: HsDimens.spacing4),
            Row(
              children: [
                Flexible(child: Text(
                    HatSpaceStrings.current.currencyFormatter(
                        symbol, price),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontStyleGuide.fwBold))),
                const SizedBox(width: HsDimens.spacing4),
                Text(HatSpaceStrings.current.pw,
                    style: Theme.of(context).textTheme.bodySmall)
              ],
            )
          ],
        ))
      ],
    );
  }
}
