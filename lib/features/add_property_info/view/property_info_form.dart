import 'package:flutter/material.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';


class PropertyName extends StatelessWidget {
  const PropertyName({super.key});
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

class PropertyPrice extends StatelessWidget {
  const PropertyPrice({super.key});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        HatSpaceLabel(
            label: HatSpaceStrings.of(context).price, isRequired: true),
        Card(
          color: Colors.white,
          elevation: 4.0,
          shadowColor: HSColor.black.withOpacity(0.2),
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: HSColor.neutral5),
              borderRadius: BorderRadius.circular(8.0)),
          child: TextFormField(
            decoration: inputTextTheme.copyWith(
                hintText: HatSpaceStrings.of(context).enterYourPrice,
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
                            "${Currency.aud.name.toUpperCase()} (\$)",
                            style: textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.w700))))),
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
        ),
      ],
    );
  }
}

class MinimumRentView extends StatelessWidget {
  const MinimumRentView({super.key});
  @override
  Widget build(context) {
    return Wrap(
      children: [
        HatSpaceLabel(
            label: HatSpaceStrings.of(context).minimumRentPeriod,
            isRequired: true),
        const SizedBox(
          height: 4,
        ),
        HatSpaceDropDownButton(
            label: HatSpaceStrings.of(context).minimumRentPeriod,
            // TODO: implement property data
            isRequired: true,
            onPressed: () {})
      ],
    );
  }
}

class PropertyDescription extends StatelessWidget {
  const PropertyDescription({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Wrap(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HatSpaceLabel(
                label: HatSpaceStrings.of(context).description,
                isRequired: false),
            // TODO: Implement Bloc State
            const Text("120/4000")
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

class StateSelectionView extends StatelessWidget {
  const StateSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return HatSpaceDropDownButton(
        label: HatSpaceStrings.of(context).state,
        //TODO: implement state
        isRequired: true,
        onPressed: () {});
  }
}

class PropertyUnitNumber extends StatelessWidget {
  const PropertyUnitNumber({super.key});
  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
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

class PropertyStreetAddress extends StatelessWidget {
  const PropertyStreetAddress({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Wrap(
      children: [
        HatSpaceLabel(
            label: HatSpaceStrings.of(context).streetAddress, isRequired: true),
        HatSpaceInputText(
          placeholder: HatSpaceStrings.of(context).enterYourAddress,
          onChanged: () {},
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          HatSpaceStrings.of(context).houseNumberAndStreetName,
          style: textTheme.bodySmall?.copyWith(color: HSColor.neutral6),
        )
      ],
    );
  }
}

class PropertySuburb extends StatelessWidget {
  const PropertySuburb({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            child: Wrap(children: [
          HatSpaceLabel(
              label: HatSpaceStrings.of(context).suburb, isRequired: true),
          HatSpaceInputText(
            placeholder: HatSpaceStrings.of(context).enterYourSuburb,
            onChanged: () {},
          )
        ])),
        const SizedBox(width: 16),
        Expanded(
            child: Wrap(children: [
          HatSpaceLabel(
              label: HatSpaceStrings.of(context).postcode, isRequired: true),
          HatSpaceInputText(
            placeholder: HatSpaceStrings.of(context).enterYourPostcode,
            onChanged: () {},
          )
        ]))
      ],
    );
  }
}

class PropertyInforForm extends StatelessWidget {
  PropertyInforForm({super.key});
  final List<Widget> itemList = [
    Builder(builder: (BuildContext context) {
      return Text(HatSpaceStrings.of(context).information,
          style: textTheme.displayLarge);
    }),
    const PropertyName(),
    const PropertyPrice(),
    const MinimumRentView(),
    const PropertyDescription(),
    Builder(builder: (BuildContext context) {
      return Text(
        HatSpaceStrings.of(context).yourAddress,
        style: textTheme.displayLarge?.copyWith(fontSize: 18.0),
      );
    }),
    const StateSelectionView(),
    const PropertyUnitNumber(),
    const PropertyStreetAddress(),
    const PropertySuburb()
  ];
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(
              left: HsDimens.spacing16,
              top: HsDimens.spacing32,
              right: HsDimens.spacing16,
              bottom: HsDimens.spacing24),
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              height: 16,
            ),
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              return itemList[index];
            },
          ),
        ));
  }
}
