import 'package:flutter/material.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

class AddPropertyDescriptionView extends StatelessWidget {
  const AddPropertyDescriptionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HsLabel(
                label: HatSpaceStrings.of(context).description,
                isRequired: false),
            // TODO: Implement Bloc State
            const Text('120/4000')
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        TextFormField(
          style: textTheme.bodyMedium,
          minLines: 3,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: inputTextTheme.copyWith(
            hintText: HatSpaceStrings.of(context).enterYourDescription,
          ),
        )
      ],
    );
  }
}
