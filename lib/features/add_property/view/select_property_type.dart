import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/features/add_property/view/date_picker_view.dart';
import 'package:hatspace/features/add_property/view/property_type_cart_view.dart';
import 'package:hatspace/features/add_property/view_model/cubit/add_property_cubit.dart';
import 'package:hatspace/features/add_property/view_model/cubit/property_type_cubit.dart';

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
        padding: const EdgeInsets.only(left: 16, top: 33, right: 16),
        child: Wrap(
          children: [
            Text(HatSpaceStrings.of(context).whatKindOfPlace,
                style: Theme.of(context).textTheme.displayLarge),
            Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                    HatSpaceStrings.of(context).chooseKindOfYourProperty,
                    style: Theme.of(context).textTheme.bodyMedium)),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: PropertyTypeCartView(position: 0),
                ),
                SizedBox(width: 15),
                Expanded(child: PropertyTypeCartView(position: 1))
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 4),
                child: Text(HatSpaceStrings.of(context).availableDate,
                    style: Theme.of(context).textTheme.bodyMedium)),
            // Show DatePicker Widget;
            const DatePickerView(),
          ],
        ),
      );
    });
  }
}
