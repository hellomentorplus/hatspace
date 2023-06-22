import 'package:flutter/material.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

class AddPropertySuburbView extends StatelessWidget {
  const AddPropertySuburbView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          HatSpaceInputText(
            label: HatSpaceStrings.of(context).suburb,
            isRequired: true,
            placeholder: HatSpaceStrings.of(context).enterYourSuburb,
            onChanged: (value) {
              // TODO: Read value from text field
            },
          )
        ])),
        const SizedBox(width: 16),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          HatSpaceInputText(
            label: HatSpaceStrings.of(context).postcode,
            isRequired: true,
            placeholder: HatSpaceStrings.of(context).enterYourPostcode,
            onChanged: (value) {},
          )
        ]))
      ],
    );
  }
}
