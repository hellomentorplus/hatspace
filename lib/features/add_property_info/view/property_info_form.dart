import 'package:flutter/material.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/add_property_info/view/add_property_address_view.dart';
import 'package:hatspace/features/add_property_info/view/add_property_description_view.dart';
import 'package:hatspace/features/add_property_info/view/add_property_minimum_rent_view.dart';
import 'package:hatspace/features/add_property_info/view/add_property_name_view.dart';
import 'package:hatspace/features/add_property_info/view/add_property_price_view.dart';
import 'package:hatspace/features/add_property_info/view/add_property_state_view.dart';
import 'package:hatspace/features/add_property_info/view/add_property_surburb.dart';
import 'package:hatspace/features/add_property_info/view/add_property_unit_view.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

class PropertyInforForm extends StatelessWidget {
  PropertyInforForm({super.key});
  final List<Widget> itemList = [
    Builder(builder: (context) {
      return Text(HatSpaceStrings.current.information,
          style: textTheme.displayLarge);
    }),
    const AddPropertyNameView(),
    const AddPropertyPriceView(),
    const AddPropertyMinimumView(),
    const AddPropertyDescriptionView(),
    Builder(builder: (context) {
      return Text(
        HatSpaceStrings.current.yourAddress,
        style: textTheme.displayLarge?.copyWith(fontSize: 18.0),
      );
    }),
    const AddPropertyStateView(),
    const AddPropertyUnitView(),
    const AddPropertyAddressView(),
    const AddPropertySurburbView()
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
