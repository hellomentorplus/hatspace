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
          label: HatSpaceStrings.current.streetAddress,
          isRequired: true,
          placeholder: HatSpaceStrings.current.enterYourAddress,
          onChanged: (value) {},
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          HatSpaceStrings.current.houseNumberAndStreetName,
          style: textTheme.bodySmall?.copyWith(color: HSColor.neutral6),
        )
      ],
    );
  }
}
