import 'package:flutter/widgets.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

class AddPropertyUnitView extends StatelessWidget {
  const AddPropertyUnitView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      HatSpaceLabel(
        label: HatSpaceStrings.of(context).unitNumber,
        isRequired: false,
        optional: HatSpaceStrings.of(context).optional,
      ),
      HatSpaceInputText(
        placeholder: HatSpaceStrings.of(context).enterYourUnitnumber,
        onChanged: () {},
      )
    ]);
  }
}
