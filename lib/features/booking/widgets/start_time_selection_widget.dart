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
  final List<int> minutesList;
  final List<int> hourList;
  const StartTimeSelectionWidget(
      {required this.minutesList, required this.hourList, super.key});

  Future<void> showStartTimeModal(BuildContext context) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(HsDimens.radius16),
          ),
        ),
        context: context,
        builder: (_) {
          DateTime prevInspection =
              context.read<AddInspectionBookingCubit>().inspectionStartTime ??
                  DateTime.now().copyWith(hour: 9, minute: 0);
          int? selectedMin = prevInspection.minute;
          // selectedMin and selectedHour should match with placeholder value
          int? selectedHour = prevInspection.hour;
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
                                color: HSColor.neutral3, width: 1.0))),
                    child: PrimaryButton(
                      label: HatSpaceStrings.current.save,
                      onPressed: () {
                        context
                            .read<AddInspectionBookingCubit>()
                            .updateInspectionStartTime(prevInspection.copyWith(
                                hour: selectedHour, minute: selectedMin));
                        context.pop();
                      },
                    ))
              ],
            ),
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HsLabel(label: HatSpaceStrings.current.startTime, isRequired: true),
        const SizedBox(height: HsDimens.spacing4),
        BlocConsumer<AddInspectionBookingCubit, AddInspectionBookingState>(
            listener: (context, state) {
          if (state is ShowStartTimeSelection) {
            showStartTimeModal(context).then((value) {
              context.read<AddInspectionBookingCubit>().closeBottomModal();
            });
          }
        }, builder: (context, state) {
          bool isStartTimeSelected =
              context.read<AddInspectionBookingCubit>().isStartTimeSelected;
          return HsDropDownButton(
              value: isStartTimeSelected
                  ? DateFormat.jm().format(context
                      .read<AddInspectionBookingCubit>()
                      .inspectionStartTime!)
                  : null,
              placeholder: HatSpaceStrings.current.startTimePlaceholder,
              placeholderStyle: placeholderStyle,
              icon: Assets.icons.chervonDown,
              onPressed: () {
                context.read<AddInspectionBookingCubit>().selectStartTime();
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
