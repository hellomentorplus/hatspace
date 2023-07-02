import 'package:flutter/material.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

class AddPropertyNameView extends StatelessWidget {
  const AddPropertyNameView({super.key});
  @override
  Widget build(BuildContext context) {
    return HatSpaceInputText(
        label: HatSpaceStrings.current.propertyName,
        isRequired: true,
        placeholder: HatSpaceStrings.current.enterPropertyName,
        onChanged: (value) {
          // TODO: Read value from text field
        });
  }
}
