import 'package:flutter/material.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

class AddPropertyMinimumView extends StatelessWidget {
  const AddPropertyMinimumView({super.key});
  @override
  Widget build(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HatSpaceLabel(
            label: HatSpaceStrings.of(context).minimumRentPeriod,
            isRequired: true),
        const SizedBox(
          height: 4,
        ),
        HatSpaceDropDownButton(
            icon: Assets.images.chervonDown,
            // TODO: implement property data
            onPressed: () {})
      ],
    );
  }
}
