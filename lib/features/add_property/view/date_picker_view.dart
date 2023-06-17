import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/features/add_property/view_model/cubit/property_type_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_buttons_settings.dart';
import 'package:hatspace/theme/widgets/hs_date_picker.dart';
import 'package:intl/intl.dart';

class DatePickerView extends StatelessWidget {
  const DatePickerView({super.key});
  @override
  Widget build(BuildContext context) {
    late ValueNotifier<DateTime> selectedDate = ValueNotifier(DateTime.now());
    return BlocSelector<PropertyTypeCubit, PropertyTypeState, DateTime>(
        selector: (state) => state.availableDate,
        builder: (context, state) {
          selectedDate.value = state;
          return SecondaryButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                          alignment: Alignment.bottomCenter,
                          insetPadding: const EdgeInsets.only(
                              bottom: 24, left: 16, right: 16),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ValueListenableBuilder(
                                    valueListenable: selectedDate,
                                    builder: ((context, value, child) {
                                      return HsDatePicker(
                                          saveSelectDate: (value) {
                                            context
                                                .read<PropertyTypeCubit>()
                                                .selectAvailableDate(value);
                                          },
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
              label: DateFormat("dd MMMM, yyyy").format(selectedDate.value),
              iconUrl: Assets.images.calendar,
              iconPosition: IconPosition.right,
              contentAlignment: MainAxisAlignment.spaceBetween,
              style: ButtonStyle(
                textStyle: MaterialStatePropertyAll(textTheme.bodyMedium),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16)),
              ));
        });
  }
}
