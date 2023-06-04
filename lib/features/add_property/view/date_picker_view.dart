import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/features/add_property/view_model/cubit/property_type_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_date_picker.dart';
import 'package:intl/intl.dart';

class DatePickerView extends StatelessWidget {
  const DatePickerView({super.key});
  @override
  Widget build(BuildContext context) {
    // print("render datepicker");
    late ValueNotifier<DateTime> selectedDate = ValueNotifier(DateTime.now());
    return BlocSelector<PropertyTypeCubit, PropertyTypeState, DateTime>(
        selector: (state) {
      return state.availableDate;
    }, builder: (context, state) {
      selectedDate = ValueNotifier(state);
      return OutlinedButton(
          onPressed: () async {
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                      alignment: Alignment.bottomCenter,
                      insetPadding: const EdgeInsets.only(
                          bottom: 24, left: 16, right: 16),
                      // backgroundColor: Colors.orangeAccent,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ValueListenableBuilder(
                                valueListenable: selectedDate,
                                builder: ((context, value, child) {
                                  return HsDatePicker(
                                      selectedDate: selectedDate);
                                }))
                          ]));
                }).then((value) {
              context
                  .read<PropertyTypeCubit>()
                  .selectAvailableDate(selectedDate.value);
              return value;
            });
          },
          // TODO: Update button theme later
          style: ButtonStyle(
              textStyle: MaterialStatePropertyAll(textTheme.bodySmall
                  ?.copyWith(fontWeight: FontWeight.w400, fontSize: 14)),
              alignment: Alignment.center,
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16)),
              shape: MaterialStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              side: const MaterialStatePropertyAll<BorderSide>(
                  BorderSide(color: HSColor.neutral3)),
              backgroundColor:
                  const MaterialStatePropertyAll<Color>(Colors.transparent),
              foregroundColor:
                  const MaterialStatePropertyAll<Color>(HSColor.neutral6)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Text(
                    DateFormat("dd MMMM, yyyy").format(selectedDate.value)),
              ),
              SvgPicture.asset(
                Assets.images.calendar,
                width: 24,
                height: 24,
              )
            ],
          ));
    });
  }
}
