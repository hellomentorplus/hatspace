import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/inspection.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/booking/view_model/cubit/add_inspection_booking_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';
import 'package:hatspace/theme/widgets/hs_time_picker.dart';

class StartTimeSelectionWidget extends StatelessWidget {
  final ValueNotifier<StartTime?> startTimeNotifer;
  final FocusNode startTimeFocusNode;
  final List<int> minutesList;
  final List<int> hourList;
  const StartTimeSelectionWidget(
      {required this.startTimeNotifer,
      required this.startTimeFocusNode,
      required this.minutesList,
      required this.hourList,
      super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier showErrorMessages  = ValueNotifier(false);
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
                      showErrorMessages.value = true;
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
                          int selectedMin = 0; // selectedMin and selectedHour should match with placeholder value
                          int selectedHour = 9;
                          return SafeArea(
                              child: SingleChildScrollView(
                            child: Column(
                              children: [
                                HatSpaceTimePicker(
                                  initalMinute: value?.getMinute?? 0, // set initialMinute with value of notifier
                                  initialHour: value?.getHour ?? 9,
                                  minutesList: minutesList,
                                  hourList: hourList,
                                  selectedMinutes: (minute) {
                                    selectedMin = minute;
                                  },
                                  selectedHour: (hour) {
                                    selectedHour = hour;
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
                                        showErrorMessages.value = false;
                                        startTimeNotifer.value = StartTime(
                                            hour: selectedHour,
                                            minute: selectedMin);
                                        context.read<AddInspectionBookingCubit>().startTime = startTimeNotifer.value!;
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
            valueListenable: showErrorMessages,
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
