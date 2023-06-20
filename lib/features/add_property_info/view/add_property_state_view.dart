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

class AddPropertyStateView extends StatelessWidget {
  AddPropertyStateView({super.key});
  final ValueNotifier<AustraliaStates> selectState =
      ValueNotifier<AustraliaStates>(AustraliaStates.values.first);
  final List<AustraliaStates> stateList = AustraliaStates.values.toList();
  @override
  Widget build(BuildContext context) {
    String label = HatSpaceStrings.of(context).pleaseSelectYourState;
    stateList.remove(AustraliaStates.invalid);
    return BlocConsumer<PropertyInforCubit, PropertyInforState>(
        listener: (context, state) {
      // TODO: listen to validation
    }, builder: (context, state) {
      if (state.propertyInfo.state != AustraliaStates.invalid) {
        selectState.value = state.propertyInfo.state;
      }
      if (state is SavePropertyInforFields) {
        label = state.propertyInfo.state.displayName;
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HatSpaceLabel(
              label: HatSpaceStrings.of(context).state, isRequired: true),
          HatSpaceDropDownButton(
              icon: Assets.images.chervonDown,
              isRequired: true,
              value: label,
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    context: context,
                    builder: (_) {
                      return HsModalView(
                          currentValue: selectState,
                          itemList: stateList,
                          height: MediaQuery.of(context).size.height * 0.85,
                          title: HatSpaceStrings.of(context).state,
                          onSave: (value) {
                            context
                                .read<PropertyInforCubit>()
                                .saveSelectedState(value);
                            context.pop();
                          });
                    });
              })
        ],
      );
    });
  }
}
