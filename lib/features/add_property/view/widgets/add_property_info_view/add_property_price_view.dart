import 'package:flutter/material.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

class AddPropertyPriceView extends StatelessWidget {
  const AddPropertyPriceView({super.key});
  @override
  Widget build(BuildContext context) {
    return HatSpaceInputText(
      label: HatSpaceStrings.current.price,
      isRequired: true,
      placeholder: HatSpaceStrings.current.enterYourPrice,
        suffixIcon: Padding(
            padding: const EdgeInsets.only(
                right: HsDimens.spacing8,
                left: HsDimens.spacing16,
                top: HsDimens.spacing8,
                bottom: HsDimens.spacing8),
            child: Container(
                padding: const EdgeInsets.all(HsDimens.spacing8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: HSColor.neutral2),
                child: Text(
                  // TODO: implement property data
                    '${Currency.aud.name.toUpperCase()} (\$)',
                    style: textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w700)))),
      onChanged: (value) {

    },);
  }
}
