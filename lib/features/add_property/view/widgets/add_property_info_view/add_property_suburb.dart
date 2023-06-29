import 'package:flutter/material.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
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
            label: HatSpaceStrings.current.suburb,
            isRequired: true,
            placeholder: HatSpaceStrings.current.enterYourSuburb,
            onChanged: (value) {
              // TODO: Read value from text field
            },
          )
        ])),
        const SizedBox(width: HsDimens.spacing16),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          HatSpaceInputText(
            label: HatSpaceStrings.current.postcode,
            isRequired: true,
            placeholder: HatSpaceStrings.current.enterYourPostcode,
            onChanged: (value) {},
          )
        ]))
      ],
    );
  }
}
