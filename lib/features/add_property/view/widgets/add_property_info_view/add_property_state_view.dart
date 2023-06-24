import 'package:flutter/material.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_modal_view.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

class AddPropertyStateView extends StatelessWidget {
  AddPropertyStateView({super.key});
  final ValueNotifier<AustraliaStates> selectState =
      ValueNotifier<AustraliaStates>(AustraliaStates.invalid);
  final List<AustraliaStates> stateList = AustraliaStates.values.toList();
  @override
  Widget build(BuildContext context) {
    stateList.remove(AustraliaStates.invalid);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HatSpaceLabel(
            label: HatSpaceStrings.of(context).state, isRequired: true),
        ValueListenableBuilder(
            valueListenable: selectState,
            builder: (_, value, child) {
              return HatSpaceDropDownButton(
                  icon: Assets.images.chervonDown,
                  isRequired: true,
                  value: selectState.value.displayName,
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        context: context,
                        builder: (_) {
                          return HsModalView(
                              key: const Key('state_view_modal'),
                              getItemString: (item) {
                                return item.displayName;
                              },
                              currentValue: selectState,
                              itemList: stateList,
                              height: MediaQuery.of(context).size.height * 0.85,
                              title: HatSpaceStrings.of(context).state,
                              onSave: (value) {
                                // TODO: handle save state on cubit
                                context.pop();
                              });
                        });
                  });
            }),
      ],
    );
  }
}
