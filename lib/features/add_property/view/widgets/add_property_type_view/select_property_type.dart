import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_type_view/date_picker_view.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_type_view/property_type_card_view.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/features/add_property/view_model/add_property_type_view_model/property_type_cubit.dart';
import 'package:hatspace/strings/l10n.dart';

class SelectPropertyType extends StatelessWidget {
  const SelectPropertyType({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PropertyTypeCubit, PropertyTypeState>(
        listener: (context, state) {
      // Implement validate to enable next button
      if (state.propertyTypes != null) {
        context.read<AddPropertyCubit>().enableNextButton();
      }
    }, builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.only(
            left: HsDimens.spacing16,
            top: HsDimens.spacing32,
            right: HsDimens.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(HatSpaceStrings.of(context).whatKindOfPlace,
                  style: Theme.of(context).textTheme.displayLarge),
            ),
            Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(top: HsDimens.spacing16),
                    child: Text(
                        HatSpaceStrings.of(context).chooseKindOfYourProperty,
                        style: Theme.of(context).textTheme.bodyMedium))),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: PropertyTypeCardView(position: 0),
                ),
                SizedBox(width: 15),
                Expanded(child: PropertyTypeCardView(position: 1))
              ],
            ),
            Flexible(
              child: Padding(
                  padding: const EdgeInsets.only(
                      top: HsDimens.spacing20, bottom: HsDimens.spacing4),
                  child: Text(HatSpaceStrings.of(context).availableDate,
                      style: Theme.of(context).textTheme.bodyMedium)),
            ),
            // Show DatePicker Widget;
            const DatePickerView(),
          ],
        ),
      );
    });
  }
}
