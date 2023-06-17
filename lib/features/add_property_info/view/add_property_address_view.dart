
import 'package:flutter/material.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

class AddPropertyAddressView extends StatelessWidget {
  const AddPropertyAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Wrap(
      children: [
        HatSpaceLabel(
            label: HatSpaceStrings.of(context).streetAddress, isRequired: true),
        HatSpaceInputText(
          placeholder: HatSpaceStrings.of(context).enterYourAddress,
          onChanged: () {},
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          HatSpaceStrings.of(context).houseNumberAndStreetName,
          style: textTheme.bodySmall?.copyWith(color: HSColor.neutral6),
        )
      ],
    );
  }
}