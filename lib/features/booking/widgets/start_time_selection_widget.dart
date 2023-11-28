import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/booking/view_model/cubit/add_inspection_booking_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';
import 'package:hatspace/theme/widgets/hs_time_picker.dart';
import 'package:intl/intl.dart';

class StartTimeSelectionWidget extends StatelessWidget {
  final ValueNotifier<DateTime?> startTimeNotifer;
  final List<int> minutesList;
  final List<int> hourList;
  const StartTimeSelectionWidget(
      {required this.startTimeNotifer,
      required this.minutesList,
      required this.hourList,
      super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HsLabel(label: HatSpaceStrings.current.startTime, isRequired: true),
        const SizedBox(height: HsDimens.spacing4),
        ValueListenableBuilder<DateTime?>(
            valueListenable: startTimeNotifer,
            builder: (context, value, child) {
              bool isStartTimeSelected =
                  context.read<AddInspectionBookingCubit>().isStartTimeSelected;
              return HsDropDownButton(
                  value: isStartTimeSelected
                      ? DateFormat.jm().format(startTimeNotifer.value!)
                      : null,
                  placeholder: DateFormat.jm().format(startTimeNotifer.value!),
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
                          int? selectedMin = startTimeNotifer.value!.minute;
                          // selectedMin and selectedHour should match with placeholder value
                          int? selectedHour = startTimeNotifer.value!.hour;
                          return SafeArea(
                              child: SingleChildScrollView(
                            child: Column(
                              children: [
                                HatSpaceTimePicker(
                                  initalMinute:
                                      selectedMin, // set initialMinute and initialHour are 0 and 9 if valueNotifer of minutes and hour = null
                                  initialHour: selectedHour,
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
                                        startTimeNotifer.value =
                                            startTimeNotifer.value!.copyWith(
                                                hour: selectedHour!,
                                                minute: selectedMin!);
                                        context
                                            .read<AddInspectionBookingCubit>()
                                            .updateInspectionStartTime(
                                                startTimeNotifer.value!);
                                        startTimeNotifer.value!;
                                        context.pop();
                                      },
                                    ))
                              ],
                            ),
                          ));
                        });
                  });
            }),
        BlocBuilder<AddInspectionBookingCubit, AddInspectionBookingState>(
            builder: (context, state) {
          if (state is RequestStartTimeSelection) {
            return Padding(
                padding: const EdgeInsets.only(top: HsDimens.spacing8),
                child: Text(
                  HatSpaceStrings.current.selectStartTimeError,
                  style: errorTextStyle,
                ));
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}
