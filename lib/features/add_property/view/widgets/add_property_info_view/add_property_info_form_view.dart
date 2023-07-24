import 'package:flutter/material.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_info_view/add_property_address_view.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_info_view/add_property_description_view.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_info_view/add_property_minimum_rent_view.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_info_view/add_property_name_view.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_info_view/add_property_price_view.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_info_view/add_property_state_view.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_info_view/add_property_suburb.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_info_view/add_property_unit_view.dart';

import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

class AddPropertyInfoFormView extends StatelessWidget {
  AddPropertyInfoFormView({super.key});
  final List<Widget> itemList = [
    Text(HatSpaceStrings.current.information, style: textTheme.displayLarge),
    const AddPropertyNameView(),
    const AddPropertyPriceView(),
    AddPropertyMinimumRentView(),
    const AddPropertyDescriptionView(),
    Text(HatSpaceStrings.current.yourAddress,
        style: textTheme.displayLarge?.copyWith(fontSize: 18.0)),
    AddPropertyStateView(),
    const AddPropertyUnitView(),
    const AddPropertyAddressView(),
    const AddPropertySuburbView()
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
              height: HsDimens.spacing16,
            ),
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              return itemList[index];
            },
          ),
        ));
  }
}
