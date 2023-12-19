import 'package:flutter/cupertino.dart';
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

class DurationSelectionWidget extends StatelessWidget {
  final ValueNotifier<int?> durationNotifer;
  final List<int>? _durationList;
  const DurationSelectionWidget(
      {required this.durationNotifer, List<int>? durationList, super.key})
      : _durationList = durationList ?? const [15, 30, 45, 60];

  void showDurationModal(BuildContext context) {
    showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(HsDimens.radius16),
              ),
            ),
            context: context,
            builder: (_) {
              int? duration = durationNotifer.value;
              return SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    HatSpaceDurationPicker(
                        initialDuration: duration,
                        durationList: _durationList!,
                        selectedDuration: (value) {
                          duration = value;
                        }),
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
                            durationNotifer.value = duration;
                            context.read<AddInspectionBookingCubit>().duration =
                                duration;
                            context.pop();
                          },
                        ))
                  ],
                ),
              ));
            })
        .then((value) => context
            .read<AddInspectionBookingCubit>()
            .validateBookingInspectionButton());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddInspectionBookingCubit, AddInspectionBookingState>(
        listener: (context, state) {
          if (state is ShowDurationSelection) {
            showDurationModal(context);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HsLabel(label: HatSpaceStrings.current.duration, isRequired: true),
            const SizedBox(height: HsDimens.spacing4),
            ValueListenableBuilder(
                valueListenable: durationNotifer,
                builder: (context, value, child) {
                  return HsDropDownButton(
                      value: durationNotifer.value == null
                          ? null
                          : '${durationNotifer.value} mins',
                      placeholder: HatSpaceStrings.current.durationPlaceHolder,
                      placeholderStyle: placeholderStyle,
                      icon: Assets.icons.chervonDown,
                      onPressed: () {
                        context
                            .read<AddInspectionBookingCubit>()
                            .selectDuration();
                      });
                }),
          ],
        ));
  }
}

class HatSpaceDurationPicker extends StatelessWidget {
  final List<int> durationList;
  final ValueChanged<int> selectedDuration;
  final int _initialDuration;
  const HatSpaceDurationPicker(
      {required this.durationList,
      required this.selectedDuration,
      int? initialDuration,
      super.key})
      : _initialDuration = initialDuration ?? 15;

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
                    scrollController: FixedExtentScrollController(
                        initialItem: durationList.indexOf(_initialDuration)),
                    onSelectedItemChanged: (int selectedItem) {
                      selectedDuration(durationList[selectedItem]);
                    },
                    children:
                        List<Widget>.generate(durationList.length, (int index) {
                      return Center(
                          child: Text(durationList[index].toString(),
                              style: timePickerStyle));
                    }),
                  ),
                ),
              ),
              const SizedBox(
                width: HsDimens.spacing24 + 3,
              ),
              Text(HatSpaceStrings.current.minuteShort, style: timePickerStyle)
            ],
          ),
        ],
      ),
    );
  }
}
