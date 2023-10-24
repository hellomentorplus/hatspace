import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

class HatSpaceTimePicker extends StatelessWidget {
  final List<int> minutesList;
  final List<int> hourList;
  final ValueChanged<int>? selectedMinutes;
  final ValueChanged<int>? selectedHour;
  final int initalMinute;
  final int initialHour;
  final VoidCallback? onSave;
  const HatSpaceTimePicker(
      {required this.minutesList,
      required this.hourList,
      int? initalMinute,
      int? initialHour,
      this.selectedMinutes,
      this.selectedHour,
      this.onSave,
      super.key})
      : initalMinute = initalMinute ?? 0,
        initialHour = initialHour ?? 9;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
            child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: HsDimens.spacing155, vertical: HsDimens.spacing16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: HsDimens.spacing195,
                      child: CupertinoPicker(
                        diameterRatio: 5.0,
                        selectionOverlay:
                            const CupertinoPickerDefaultSelectionOverlay(
                          background: Colors.transparent,
                        ),
                        magnification: 1.5,
                        squeeze: 1,
                        useMagnifier: true,
                        itemExtent: 32,
                        // This sets the initial item.
                        scrollController: FixedExtentScrollController(
                            initialItem: hourList.indexOf(initialHour)),
                        // This is called when selected item is changed.
                        onSelectedItemChanged: (int selectedItem) {
                          selectedHour!(hourList[selectedItem]);
                        },
                        children:
                            List<Widget>.generate(hourList.length, (int index) {
                          return Center(
                              child: Text(hourList[index].toString(),
                                  style: timePickerStyle));
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: HsDimens.spacing27,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 195,
                      child: CupertinoPicker(
                        diameterRatio: 4.0,
                        selectionOverlay:
                            const CupertinoPickerDefaultSelectionOverlay(
                          background: Colors.transparent,
                        ),
                        magnification: 1.5,
                        squeeze: 1,
                        useMagnifier: true,
                        itemExtent: 32,
                        // This sets the initial item.
                        scrollController: FixedExtentScrollController(
                          initialItem: minutesList.indexOf(initalMinute),
                        ),
                        // This is called when selected item is changed.
                        onSelectedItemChanged: (int selectedItem) {
                          selectedMinutes!(minutesList[selectedItem]);
                        },
                        children: List<Widget>.generate(minutesList.length,
                            (int index) {
                          return Center(
                              child: Text(
                            minutesList[index].toString(),
                            style: timePickerStyle,
                          ));
                        }),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
            padding: const EdgeInsets.symmetric(
                horizontal: HsDimens.spacing16, vertical: HsDimens.spacing8),
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(color: HSColor.neutral3, width: 1.0))),
            child: PrimaryButton(
              label: HatSpaceStrings.current.save,
              onPressed: onSave,
            ))
      ],
    )));
  }
}
