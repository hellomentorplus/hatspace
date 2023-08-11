import 'package:flutter/material.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_buttons_settings.dart';
import 'package:hatspace/theme/widgets/hs_date_picker.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';
import 'package:intl/intl.dart';

class AddInspectionBooking extends StatelessWidget {
  AddInspectionBooking({Key? key}) : super(key: key);
   final ValueNotifier<DateTime> _selectedDate = ValueNotifier(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context){
        return Scaffold(
          body: SafeArea(child: 
                 SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: HsDimens.spacing24, horizontal: HsDimens.spacing16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(HatSpaceStrings.current.addInspectionBooking),
                const SizedBox(height: HsDimens.spacing16),
                Padding(padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
                child:     Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: Assets.images.signInBackground.provider(),
                          fit: BoxFit.cover)
                      ),
                    ),
                    const SizedBox(width: HsDimens.spacing16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(HatSpaceStrings.current.house),
                          Text(HatSpaceStrings.current.description),
                          Text(HatSpaceStrings.current.location),
                          Text(HatSpaceStrings.current.price)
                        ],
                      ) 
                    )
                  ],
                )
                ),
                const SizedBox(height: HsDimens.spacing24),
       Padding(
                  padding: const EdgeInsets.only(
                      top: HsDimens.spacing20, bottom: HsDimens.spacing4),
                  child: Text(HatSpaceStrings.current.availableDate,
                      style: Theme.of(context).textTheme.bodyMedium)),
 ValueListenableBuilder<DateTime>(
              valueListenable: _selectedDate,
              builder: (context, value, child) => _DatePickerView(
                selectedDate: value,
                onSelectedDate: (value) {
                  _selectedDate.value = value;
                },
              ),
            ),
            const SizedBox(height: HsDimens.spacing16,),
              Row(
                children: [
                  Expanded(
                    child: 
                    Row(children: [
                      Text(HatSpaceStrings.current.startTime),
                      
                    ],)
                  ),
                  Expanded(child: 
                    Row(
                      children: [
                        Text(HatSpaceStrings.current.endTime)
                      ],
                    )
                  )
                ],
              ),

              const SizedBox(height: 16,),
              Text(HatSpaceStrings.current.notes)

              ],
            ),
          ),
          )
        );
      }
      );
  }
}


class _DatePickerView extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onSelectedDate;

  const _DatePickerView(
      {required this.selectedDate, required this.onSelectedDate});

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return Dialog(
                    alignment: Alignment.bottomCenter,
                    insetPadding: const EdgeInsets.only(
                        bottom: HsDimens.spacing24,
                        left: HsDimens.spacing16,
                        right: HsDimens.spacing16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(HsDimens.radius16)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          HsDatePicker(
                            saveSelectDate: (date) {
                              onSelectedDate(date);
                              Navigator.pop(context); // Dismiss the dialog
                            },
                            selectedDate: selectedDate,
                          )
                        ]));
              });
        },
        label: DateFormat('dd MMMM, yyyy').format(selectedDate),
        iconUrl: Assets.icons.calendar,
        iconPosition: IconPosition.right,
        contentAlignment: MainAxisAlignment.spaceBetween,
        style: ButtonStyle(
          textStyle: MaterialStatePropertyAll(textTheme.bodyMedium),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(
                  vertical: HsDimens.spacing12,
                  horizontal: HsDimens.spacing16)),
        ));
  }
}