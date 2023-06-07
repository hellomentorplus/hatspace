import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_button_theme.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_buttons_settings.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

class HatSpaceDropDownButton extends StatelessWidget {
  final String label;
  final bool isRequired;
  final String? placeholder;
  final VoidCallback onPressed;
  const HatSpaceDropDownButton(
      {super.key,
      required this.label,
      bool? isRequired,
      required this.onPressed,
      this.placeholder})
      : isRequired = isRequired ?? false;
  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
        // TODO: implement placeholder with enum of preriod
        label: placeholder ?? "Please select value",
        iconUrl: Assets.images.chervonDown,
        iconPosition: IconPosition.right,
        contentAlignment: MainAxisAlignment.spaceBetween,
        style: secondaryButtonTheme.style?.copyWith(
            textStyle: MaterialStatePropertyAll<TextStyle?>(
              Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
            padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.fromLTRB(16, 13, 12, 13))),
        onPressed: onPressed);
  }
}

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
      // crossAxisAlignment: CrossAxisAlignment.start,
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
                        right: 7, left: 16, top: 7, bottom: 7),
                    child: Container(
                        padding: const EdgeInsets.all(8),
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

class PropertyRentPeriod extends StatelessWidget {
  const PropertyRentPeriod({super.key});

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
            // TODO: Implement BS
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

class PropertyState extends StatelessWidget {
  const PropertyState({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return HatSpaceDropDownButton(
        label: HatSpaceStrings.of(context).state,
        //TODO: implement state
        isRequired: true,
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              builder: (BuildContext context) {
                return 
                Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                    child: Column(
                      
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(child: Text("")),
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child:  Text(
                              HatSpaceStrings.of(context).state,
                              style: textTheme.displayLarge
                                  ?.copyWith(fontSize: 16.0),
                            ),)
                            ),
                            Expanded(
                              child:
                              Align(
                                alignment:Alignment.centerRight ,
                                    child:    SvgPicture.asset(
                              Assets.images.closeIcon,
                            )
                              )
                          
                            )
                         
                          ],
                        ),
                        Expanded(
                            child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                            height: 16,
                          ),
                          itemCount: AustraliaStates.values.length,
                          itemBuilder: (context, index) {
                            return Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding:const EdgeInsets.symmetric(vertical: 16.0),
                                  child:  Text(
                                    AustraliaStates.values[index].stateName) ,
                                ) 
                              );
                          },
                        ))
                      ],
                    ))
                );
                
              });
        });
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
    const PropertyRentPeriod(),
    const PropertyDescription(),
    Builder(builder: (BuildContext context) {
      return Text(
        HatSpaceStrings.of(context).yourAddress,
        style: textTheme.displayLarge?.copyWith(fontSize: 18.0),
      );
    }),
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
          padding:
              const EdgeInsets.only(left: 16, top: 33, right: 16, bottom: 24),
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
