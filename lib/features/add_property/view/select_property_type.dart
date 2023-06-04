import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/add_property/view/add_property_view.dart';
import 'package:hatspace/features/add_property/view/date_picker_view.dart';
import 'package:hatspace/features/add_property/view/property_type_cart_view.dart';
import 'package:hatspace/features/add_property/view_model/cubit/add_property_cubit.dart';
import 'package:hatspace/features/add_property/view_model/cubit/add_property_state.dart';
import 'package:hatspace/features/add_property/view_model/cubit/property_type_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_buttons_settings.dart';

import '../../home/view/home_view.dart';

class SelectPropertyType extends StatelessWidget {
  SelectPropertyType({super.key});
  final List<Widget> pages = [const AddPropertyView()];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PropertyTypeCubit, PropertyTypeState>(
        listener: (context, state) {
      if (state.availableDate.day != DateTime.now().day) {
        context.read<AddPropertyCubit>().enableNextButton();
      }
    }, builder: (context, state) {
      // print("render property body");
      return Padding(
        padding: const EdgeInsets.only(left: 16, top: 33, right: 16),
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
            Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 4),
                child: Text(
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
