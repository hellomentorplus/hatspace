import 'package:flutter/material.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_modal_view.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

class MinimumRentPeriodView extends StatelessWidget {
  MinimumRentPeriodView({super.key});
  final ValueNotifier<MinimumRentPeriod> selectPeriod =
      ValueNotifier<MinimumRentPeriod>(MinimumRentPeriod.invalid);
  final List<MinimumRentPeriod> periodList = MinimumRentPeriod.values.toList();
  @override
  Widget build(BuildContext context) {
    periodList.remove(MinimumRentPeriod.invalid);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HatSpaceLabel(
            label: HatSpaceStrings.of(context).minimumRentPeriod,
            isRequired: true),
        ValueListenableBuilder(
            valueListenable: selectPeriod,
            builder: (_, value, child) {
              return HatSpaceDropDownButton(
                  icon: Assets.images.chervonDown,
                  value: selectPeriod.value.displayName,
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
                              key: const Key('rent_view_modal'),
                              currentValue: selectPeriod,
                              getItemString: (item) => item.displayName,
                              itemList: periodList,
                              height: MediaQuery.of(context).size.height * 0.85,
                              title:
                                  HatSpaceStrings.of(context).minimumRentPeriod,
                              onSave: (value) {
                                // TODO handle save state on cubit
                                context.pop();
                              });
                        });
                  });
            })
      ],
    );
  }
}
