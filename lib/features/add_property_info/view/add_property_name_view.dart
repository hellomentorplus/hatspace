import 'package:flutter/material.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

class AddPropertyNameView extends StatelessWidget {
  const AddPropertyNameView({super.key});
  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      HatSpaceLabel(
        label: HatSpaceStrings.of(context).propertyName,
        isRequired: true,
      ),
      HatSpaceInputText(
        placeholder: HatSpaceStrings.of(context).enterPropertyName,
        onChanged: () {},
      )
    ]);
  }
}
