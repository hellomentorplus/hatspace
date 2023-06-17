import 'package:flutter/material.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

class AddPropertyStateView extends StatelessWidget {
  const AddPropertyStateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HatSpaceLabel(
          label: HatSpaceStrings.of(context).state,
          isRequired: true,
        ),
        HatSpaceDropDownButton(
            icon: Assets.images.chervonDown, onPressed: () {})
      ],
    );
  }
}
