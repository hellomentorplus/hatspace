import 'package:flutter/material.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

class AddPropertyAddressView extends StatelessWidget {
  const AddPropertyAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HatSpaceInputText(
          label: HatSpaceStrings.of(context).streetAddress,
          isRequired: true,
          placeholder: HatSpaceStrings.of(context).enterYourAddress,
          onChanged: (value) {},
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
