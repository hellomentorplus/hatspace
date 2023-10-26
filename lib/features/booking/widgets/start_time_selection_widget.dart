import 'package:flutter/material.dart';
import 'package:hatspace/data/inspection.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';
import 'package:hatspace/theme/widgets/hs_time_picker.dart';

class StartTimeSelectionWidget extends StatelessWidget {
  final ValueNotifier<StartTime?> startTimeNotifer;
  final ValueNotifier startTimeErrorMessage;
  final FocusNode startTimeFocusNode;
  final List<int> minutesList;
  final List<int> hourList;
  const StartTimeSelectionWidget(
      {required this.startTimeNotifer,
      required this.startTimeFocusNode,
      required this.startTimeErrorMessage,
      required this.minutesList,
      required this.hourList,
      super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HsLabel(label: HatSpaceStrings.current.startTime, isRequired: true),
        const SizedBox(height: HsDimens.spacing4),
        ValueListenableBuilder<StartTime?>(
            valueListenable: startTimeNotifer,
            builder: (context, value, child) {
              return HsDropDownButton(
                  focusNode: startTimeFocusNode,
                  onFocusChange: (value) {
                    if (startTimeNotifer.value == null) {
                      startTimeErrorMessage.value = true;
                    }
                  },
                  value: startTimeNotifer.value == null
                      ? null
                      : value?.getStringStartTime,
                  placeholder:
                      const StartTime(hour: 9, minute: 0).getStringStartTime,
                  placeholderStyle: placeholderStyle,
                  icon: Assets.icons.chervonDown,
                  onPressed: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(HsDimens.radius16),
                          ),
                        ),
                        context: context,
                        builder: (_) {
                          int? intialMin = startTimeNotifer.value == null
                              ? 0
                              : value?.getMinute;
                          int? intialHour =
                              startTimeNotifer.value == null ? 9 : value?.hour;
                          return SafeArea(
                              child: SingleChildScrollView(
                            child: Column(
                              children: [
                                HatSpaceTimePicker(
                                  initalMinute: intialMin,
                                  initialHour: intialHour,
                                  minutesList: minutesList,
                                  hourList: hourList,
                                  selectedMinutes: (minute) {
                                    intialMin = minute;
                                  },
                                  selectedHour: (hour) {
                                    intialHour = hour;
                                  },
                                ),
                                const SizedBox(height: HsDimens.spacing16),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: HsDimens.spacing16,
                                        vertical: HsDimens.spacing8),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: HSColor.neutral3,
                                                width: 1.0))),
                                    child: PrimaryButton(
                                      label: HatSpaceStrings.current.save,
                                      onPressed: () {
                                        startTimeErrorMessage.value = false;
                                        startTimeNotifer.value = StartTime(
                                            hour: intialHour!,
                                            minute: intialMin!);
                                        context.pop();
                                      },
                                    ))
                              ],
                            ),
                          ));
                        });
                  });
            }),
        ValueListenableBuilder(
            valueListenable: startTimeErrorMessage,
            builder: (context, value, child) {
              if (value == true) {
                return Padding(
                    padding: const EdgeInsets.only(top: HsDimens.spacing8),
                    child: Text(
                      HatSpaceStrings.current.selectStartTimeError,
                      style: errorTextStyle,
                    ));
              }
              return const SizedBox.shrink();
            })
      ],
    );
  }
}
