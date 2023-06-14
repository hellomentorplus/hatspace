import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatspace/data/property_data.dart';

import 'package:hatspace/features/add_property_info/view/property_info_form.dart';
import 'package:hatspace/features/add_property_info/view_modal/property_infor_cubit.dart';
import 'package:hatspace/features/add_property_info/view_modal/property_infor_state.dart';

import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_modal_view.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

class StateSelectionView extends StatelessWidget {
  StateSelectionView({super.key});
  final ValueNotifier<AustraliaStates> selectState =
      ValueNotifier<AustraliaStates>(AustraliaStates.values.first);
  final List<AustraliaStates> stateList = AustraliaStates.values.toList();
  @override
  Widget build(BuildContext context) {
    String label = HatSpaceStrings.of(context).pleaseSelectYourState;
    stateList.remove(AustraliaStates.invalid);
    // TODO: implement build
    return BlocBuilder<PropertyInforCubit, PropertyInforState>(
        builder: (context, state) {
      if (state.savedState != AustraliaStates.invalid) {
        selectState.value = state.savedState;
      }
      if (state is SaveSelectedState) {
        label = state.savedState.getName;
        context.pop();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HatSpaceLabel(
              label: HatSpaceStrings.of(context).state, isRequired: true),
          HatSpaceDropDownButton(
              label: label,
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
                          key: const Key("state_bottom_sheet"),
                          currentValue: selectState,
                          itemList: stateList,
                          height: MediaQuery.of(context).size.height * 0.85,
                          title: HatSpaceStrings.of(context).state,
                          onSave: (value) {
                            context
                                .read<PropertyInforCubit>()
                                .saveSelectedState(value);
                          });
                    });
              })
        ],
      );
    });
  }
}
