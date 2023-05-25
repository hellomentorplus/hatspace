import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/add_property/view/date_picker_view.dart';
import 'package:hatspace/features/add_property/view/property_type_cart_view.dart';
import 'package:hatspace/features/add_property/view_model/bloc/add_property_bloc.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

class SelectPropertyType extends StatelessWidget {
  const SelectPropertyType({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddPropertyBloc, AddPropertyState, PropertyTypes>(
        selector: (state) {
      return state.propertyTypes;
    }, builder: (context, state) {
      // print("render property body");
      return Padding(
        padding: const EdgeInsets.only(left:16, top:33,right:16),
        child: Wrap(
          children: [
            Text(HatSpaceStrings.of(context).selectingRoleScreenTitle,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: 24,
                    color: HSColor.onSurface,
                    fontWeight: FontWeight.w700)),
            Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                    HatSpaceStrings.of(context).selectigRoleScreenSubtitle,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.w400, fontSize: 14))),
            GridView.builder(
                padding: const EdgeInsets.only(top: 32),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                ),
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (BuildContext context, int position) {
                  return PropertyTypeCartView(
                    position: position,
                  );
                }),
            Padding(padding: const EdgeInsets.only(top: 20,bottom: 4),
            child:   Text(
              HatSpaceStrings.of(context).availableDate,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: HSColor.onSurface),
            )),
            // Show DatePicker Widget;
             const DatePickerView(),
          ],
        ),
      );
    });
  }
}
