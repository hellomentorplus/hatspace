import 'package:flutter/material.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_button_theme.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_button_settings.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

class HatSpaceInputText extends StatelessWidget {
  final String label;
  final String placeholder;
  final bool isRequired;
  final bool optionalLabel;
  final VoidCallback onChanged;

  const HatSpaceInputText(
      {super.key,
      required this.label,
      bool? isRequired,
      required this.placeholder,
      required this.onChanged,
      bool? optionalLabel})
      : isRequired = isRequired ?? false,
        optionalLabel = optionalLabel ?? false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                text: label,
                children: [
              TextSpan(
                  text: isRequired
                      ? " *"
                      : optionalLabel
                          ? " (Optional)"
                          : "",
                  style: textTheme.bodyMedium?.copyWith(
                      color: isRequired ? HSColor.requiredField : null))
            ])),
        TextFormField(
            onChanged: (value) {
              // TODO: implement bloc
              print(value);
            },
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
            decoration: inputTextTheme.copyWith(hintText: placeholder))
      ],
    );
  }
}

class HatSpaceDropDownButton extends StatelessWidget {
  final String label;
  final bool isRequired;
  final String placeholder;
  final VoidCallback onPressed;
  const HatSpaceDropDownButton(
      {super.key,
      required this.label,
      bool? isRequired,
      required this.onPressed,
      required this.placeholder})
      : isRequired = isRequired ?? false;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        RichText(
            text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                text: label,
                children: [
              TextSpan(
                  text: isRequired ? " *" : "",
                  style: textTheme.bodyMedium
                      ?.copyWith(color: HSColor.requiredField))
            ])),
        SecondaryButton(
          // TODO: implement placeholder with enum of preriod
          label: placeholder,
          iconUrl: Assets.images.chervonDown,
          iconPosition: IconPosition.right,
          contentAlignment: MainAxisAlignment.spaceBetween,
          style: secondaryButtonTheme.style?.copyWith(
              textStyle: MaterialStatePropertyAll<TextStyle?>(
                Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
              ),
              padding: const MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.fromLTRB(16, 13, 12, 13))),
          onPressed: () {
            // TODO: implement show rent period
          },
        ),
      ],
    );
  }
}

// input THEME
InputDecoration inputTextTheme = InputDecoration(
    contentPadding: const EdgeInsets.fromLTRB(16, 13, 12, 13),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: HSColor.black,
        )),
    hintText: "Please enter your placeholder",
    hintStyle:
        textTheme.bodyMedium?.copyWith(height: 1.0, color: HSColor.neutral5));

class PropertyName extends StatelessWidget {
  const PropertyName({super.key});

  @override
  Widget build(BuildContext context) {
    return HatSpaceInputText(
      label: HatSpaceStrings.of(context).propertyNameLabel,
      placeholder: HatSpaceStrings.of(context).propertyNamePlaceholder,
      isRequired: true,
      onChanged: () {},
    );
  }
}

class PropertyPrice extends StatelessWidget {
  const PropertyPrice({super.key});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                text: HatSpaceStrings.of(context).priceLabel,
                children: [
              TextSpan(
                  text: " *",
                  style: textTheme.bodyMedium
                      ?.copyWith(color: HSColor.requiredField))
            ])),
        Card(
          color: Colors.white,
          elevation: 4.0,
          shadowColor: HSColor.black.withOpacity(0.2),
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: HSColor.neutral5),
              borderRadius: BorderRadius.circular(8.0)),
          child: TextFormField(
            decoration: inputTextTheme.copyWith(
                hintText: HatSpaceStrings.of(context).pricePlaceholder,
                suffixIcon: Padding(
                    padding: const EdgeInsets.only(
                        right: 7, left: 16, top: 7, bottom: 7),
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: HSColor.neutral2),
                        child: const Text(
                          // TODO: implement property data
                          "USD (\$)",
                          style: TextStyle(),
                        )))),
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
        ),
      ],
    );
  }
}

class PropertyRentPeriod extends StatelessWidget {
  const PropertyRentPeriod({super.key});
  @override
  Widget build(context) {
    return HatSpaceDropDownButton(
        label: HatSpaceStrings.of(context).minimumRentPeriodlabel,
        // TODO: implement property data
        placeholder: "6 months",
        isRequired: true,
        onPressed: () {});
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
            Text(HatSpaceStrings.of(context).descriptionLabel),
            // TODO: Change state
            Text("120/4000")
          ],
        ),
        TextFormField(
          style: textTheme.bodyMedium,
          minLines: 3,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: inputTextTheme.copyWith(
            hintText: HatSpaceStrings.of(context).descriptionPlaceholder,
          ),
        )
      ],
    );
  }
}

class PropertyState extends StatelessWidget {
  const PropertyState({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return HatSpaceDropDownButton(
        label: HatSpaceStrings.of(context).stateLabel,
        //TODO: implement state
        placeholder: "Select",
        isRequired: true,
        onPressed: () {});
  }
}

class PropertyUnitNumber extends StatelessWidget {
  const PropertyUnitNumber({super.key});
  @override
  Widget build(BuildContext context) {
    return HatSpaceInputText(
      label: HatSpaceStrings.of(context).unitNumberLabel,
      placeholder: HatSpaceStrings.of(context).unitNumberPlaceholder,
      optionalLabel: true,
      onChanged: () {},
    );
  }
}

class PropertyStreetAddress extends StatelessWidget {
  const PropertyStreetAddress({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Wrap(
      children: [
        HatSpaceInputText(
          label: HatSpaceStrings.of(context).addressLabel,
          placeholder: HatSpaceStrings.of(context).addressPlaceholder,
          isRequired: true,
          onChanged: () {},
        ),
       const SizedBox(
          height: 8,
        ),
        Text(
          HatSpaceStrings.of(context).addressHints,
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
          child: HatSpaceInputText(
            label: "Suburb",
            placeholder: "Enter Suburb",
            isRequired: true,
            onChanged: () {},
          ),
        ),
        SizedBox(width: 16),
        Expanded(
            child: HatSpaceInputText(
          label: "Postcode",
          placeholder: "Enter Postcode",
          isRequired: true,
          onChanged: () {},
        ))
      ],
    );
  }
}

class PropertyInforForm extends StatelessWidget {
  PropertyInforForm({super.key});
  final List<Widget> itemList = [
    const Text("Information",
        style: TextStyle(
            fontSize: 24,
            color: HSColor.onSurface,
            fontWeight: FontWeight.w700)),
    const PropertyName(),
    const PropertyPrice(),
    const PropertyRentPeriod(),
    const PropertyDescription(),
    const Text("Your address",
        style: TextStyle(
            fontSize: 18,
            color: HSColor.onSurface,
            fontWeight: FontWeight.w700)),
    const PropertyState(),
    const PropertyUnitNumber(),
    const PropertyStreetAddress(),
    const PropertySuburb()
  ];
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 33, right: 16),
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
