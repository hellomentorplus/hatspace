import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/add_property_info/view_modal/property_infor_cubit.dart';
import 'package:hatspace/features/add_property_info/view_modal/property_infor_state.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_modal_view.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

class AddPropertyMinimumView extends StatelessWidget {
  AddPropertyMinimumView({super.key});
  final ValueNotifier<MinimumRentPeriod> selectPeriod =
      ValueNotifier<MinimumRentPeriod>(MinimumRentPeriod.values.first);
  final List<MinimumRentPeriod> periodList = MinimumRentPeriod.values.toList();

  @override
  Widget build(BuildContext context) {
    String label = HatSpaceStrings.of(context).pleaseSelectRentPeriod;
    periodList.remove(MinimumRentPeriod.invalid);
    return BlocBuilder<PropertyInforCubit, PropertyInforState>(
        builder: (context, state) {
      if (state.saveRentPeriod != MinimumRentPeriod.invalid) {
        selectPeriod.value = state.saveRentPeriod;
      }
      if (state is SaveMinimumPeriodState) {
        label = state.saveRentPeriod.displayName;
        context.pop();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HatSpaceLabel(
              label: HatSpaceStrings.of(context).minimumRentPeriod,
              isRequired: true),
          HatSpaceDropDownButton(
              icon: Assets.images.chervonDown,
              value: label,
              //TODO: implement state
              isRequired: true,
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    context: context,
                    builder: (_) {
                      return HsModalView(
                          key: const Key("minimum_rent_bottom_sheet"),
                          currentValue: selectPeriod,
                          itemList: periodList,
                          height: MediaQuery.of(context).size.height * 0.85,
                          title: HatSpaceStrings.of(context).minimumRentPeriod,
                          onSave: (value) {
                            context
                                .read<PropertyInforCubit>()
                                .saveMinimumRentPeriod(value);
                          });
                    });
              })
        ],
      );
    });
  }
}
