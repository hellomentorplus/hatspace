import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/theme/hs_theme.dart';

class HatSpaceTimePicker extends StatelessWidget {
  final List<int> minutesList;
  final List<int> hourList;
  final ValueChanged<int> selectedMinutes;
  final ValueChanged<int> selectedHour;
  final int initalMinute;
  final int initialHour;
  const HatSpaceTimePicker(
      {required this.minutesList,
      required this.hourList,
      required this.selectedMinutes,
      required this.selectedHour,
      int? initalMinute,
      int? initialHour,
      super.key})
      : initalMinute = initalMinute ?? 0,
        initialHour = initialHour ?? 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: HsDimens.spacing155,
          right: HsDimens.spacing155,
          top: HsDimens.spacing16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                    height: HsDimens.spacing195,
                    child: ListWheelScrollView(
                        controller: FixedExtentScrollController(
                            initialItem: hourList.indexOf(initialHour)),
                        useMagnifier: true,
                        overAndUnderCenterOpacity: 0.5,
                        itemExtent: 32,
                        diameterRatio: 5.0,
                        magnification: 1.5,
                        squeeze: 1,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (int selectedItem) {
                          selectedHour(hourList[selectedItem]);
                        },
                        children:
                            List<Widget>.generate(hourList.length, (int index) {
                          return Center(
                            child: Text(hourList[index].toString(),
                                style: timePickerStyle),
                          );
                        }))),
              ),
              const SizedBox(
                width: HsDimens.spacing24 + 3,
              ),
              Expanded(
                child: SizedBox(
                  height: 195,
                  child: ListWheelScrollView(
                    diameterRatio: 4.0,
                    magnification: 1.5,
                    squeeze: 1,
                    useMagnifier: true,
                    itemExtent: 32,
                    overAndUnderCenterOpacity: 0.5,
                    physics: const FixedExtentScrollPhysics(),
                    controller: FixedExtentScrollController(
                      initialItem: minutesList.indexOf(initalMinute),
                    ),
                    onSelectedItemChanged: (int selectedItem) {
                      selectedMinutes(minutesList[selectedItem]);
                    },
                    children:
                        List<Widget>.generate(minutesList.length, (int index) {
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
    );
  }
}
