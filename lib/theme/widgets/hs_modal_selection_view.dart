import 'package:flutter/material.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_modal_view.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

class HsModalSelectionView<T> extends StatelessWidget {
  final String? label;
  final bool? isRequired;
  final List<T> itemList;
  final GetItemString<T> dislayName;
  final ValueNotifier<T> selection;
  final ValueChanged onValueChanges;
  const HsModalSelectionView(
      {required this.itemList,
      required this.dislayName,
      required this.selection,
      required this.onValueChanges,
      this.label,
      this.isRequired,
      super.key});
  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetList = [];
    if (label != null) {
      widgetList
          .add(HatSpaceLabel(label: label, isRequired: isRequired ?? false));
    }
    widgetList.add(ValueListenableBuilder(
        valueListenable: selection,
        builder: (_, value, child) {
          return HatSpaceDropDownButton(
              icon: Assets.images.chervonDown,
              isRequired: true,
              value: dislayName(value),
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    context: context,
                    builder: (_) {
                      return HsModalView<T>(
                          getItemString: dislayName,
                          selection: selection.value,
                          itemList: itemList,
                          title: HatSpaceStrings.of(context).state,
                          onSave: (value) {
                            selection.value = value;
                            onValueChanges(value);
                          });
                    });
              });
        }));

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: widgetList);
  }
}
