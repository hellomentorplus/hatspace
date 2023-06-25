import 'package:flutter/material.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_modal_view.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

class HsModalSelectionView<T> extends StatelessWidget {
  final List<T> itemList;
  final GetItemString<T> dislayName;
  final ValueNotifier<T> initialValue;
  final ValueChanged onValueChanges;
  const HsModalSelectionView(
      {required this.itemList,
      required this.dislayName,
      required this.initialValue,
      required this.onValueChanges,
      super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HatSpaceLabel(
            label: HatSpaceStrings.of(context).state, isRequired: true),
        ValueListenableBuilder(
            valueListenable: initialValue,
            builder: (_, value, child) {
              return HatSpaceDropDownButton(
                  icon: Assets.images.chervonDown,
                  isRequired: true,
                  value: dislayName(initialValue.value),
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        context: context,
                        builder: (_) {
                          return HsModalView(
                              getItemString: dislayName,
                              currentValue: initialValue,
                              itemList: itemList,
                              height: MediaQuery.of(context).size.height * 0.85,
                              title: HatSpaceStrings.of(context).state,
                              onSave: onValueChanges);
                        });
                  });
            }),
      ],
    );
  }
}
