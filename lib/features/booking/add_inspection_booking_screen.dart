import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/booking/view_model/cubit/add_inspection_booking_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_buttons_settings.dart';
import 'package:hatspace/theme/widgets/hs_date_picker.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

class AddInspectionBookingScreen extends StatelessWidget {
  const AddInspectionBookingScreen({super.key});

  @override
  Widget build(Object context) {
    // TODO: implement build
    return BlocProvider<AddInspectionBookingCubit>(
      create: (context) => AddInspectionBookingCubit(),
      child: AddInspectionBookingBody(),
    );
  }
}

class AddInspectionBookingBody extends StatelessWidget {
  AddInspectionBookingBody({Key? key}) : super(key: key);
  final ValueNotifier<DateTime> _selectedDate =
      ValueNotifier(DateTime.parse('2023-09-15'));

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddInspectionBookingCubit, AddInspectionBookingState>(
        listener: (context, state) {
          if (state is BookingInspectionSuccess) {
            context.pushToSuccessScreen();
          }
        },
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: HSColor.background,
              leading: null,
              automaticallyImplyLeading: false,
              shadowColor: Colors.transparent,
              toolbarHeight: 0,
            ),
            bottomNavigationBar: BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(HsDimens.spacing16,
                    HsDimens.spacing8, HsDimens.spacing16, HsDimens.spacing28),
                child: PrimaryButton(
                  label: HatSpaceStrings.of(context).bookInspection,
                  onPressed: () {
                    // TODO: implemnt booking logic
                    context
                        .read<AddInspectionBookingCubit>()
                        .onBookInspection();
                  },
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: HsDimens.spacing16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            HatSpaceStrings.current.addInspectionBooking,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(),
                            child: IconButton(
                              icon: SvgPicture.asset(
                                Assets.icons.closeIcon,
                                width: HsDimens.size32,
                                height: HsDimens.size32,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )),
                      ],
                    ),
                    BookedItemCard(
                      propertyName: 'Green living space in Melbourne',
                      propertyType: HatSpaceStrings.current.apartment,
                      propertyImage:
                          'https://m.media-amazon.com/images/I/81YR16yC2QL._AC_UF350,350_QL80_.jpg',
                      price: 4800,
                      state: 'Victoria',
                      currency: Currency.aud,
                      rentingPeriod: 'pw',
                      onPressed: () {
                        // TODO: implement BL
                      },
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            top: HsDimens.spacing20, bottom: HsDimens.spacing4),
                        child: HsLabel(
                            label: HatSpaceStrings.current.date,
                            isRequired: true)),
                    ValueListenableBuilder<DateTime>(
                      valueListenable: _selectedDate,
                      builder: (context, value, child) => _DatePickerView(
                        selectedDate: value,
                        onSelectedDate: (value) {
                          _selectedDate.value = value;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: HsDimens.spacing16,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HsLabel(
                                label: HatSpaceStrings.current.startTime,
                                isRequired: true),
                            const SizedBox(height: HsDimens.spacing4),
                            HsDropDownButton(
                                value: '09:00 AM',
                                icon: Assets.icons.chervonDown,
                                onPressed: () {})
                          ],
                        )),
                        const SizedBox(width: HsDimens.spacing15),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HsLabel(
                                label: HatSpaceStrings.current.endTime,
                                isRequired: true),
                            const SizedBox(height: HsDimens.spacing4),
                            HsDropDownButton(
                                value: '10:00 AM',
                                icon: Assets.icons.chervonDown,
                                onPressed: () {})
                          ],
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    HsLabel(
                        label: HatSpaceStrings.current.notes,
                        optional: HatSpaceStrings.current.optional),
                    const SizedBox(
                      height: HsDimens.spacing4,
                    ),
                    TextFormField(
                      initialValue: 'My number is 0433123456',
                      style: textTheme.bodyMedium,
                      minLines: 4,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      maxLength: 4,
                      decoration: inputTextTheme.copyWith(
                        hintText: HatSpaceStrings.current.enterYourDescription,
                        counterText: '',
                        semanticCounterText: '',
                      ),
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
            )));
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
        label: HatSpaceStrings.current.dateFormatterWithDate(selectedDate),
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

class BookedItemCard extends StatelessWidget {
  final String propertyImage;
  final String propertyName;
  final String propertyType;
  final double price;
  final Currency currency;
  final String state;
  final VoidCallback onPressed;
  final String rentingPeriod;
  final Color? _shadowColor;
  final EdgeInsets padding;
  // Add style for card

  const BookedItemCard({
    required this.propertyImage,
    required this.propertyName,
    required this.propertyType,
    required this.price,
    required this.currency,
    required this.state,
    required this.onPressed,
    required this.rentingPeriod,
    EdgeInsets? padding,
    Color? shadowColor,
    Key? key,
  })  : padding = padding ?? const EdgeInsets.all(HsDimens.spacing16),
        _shadowColor = shadowColor,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: _shadowColor,
      elevation: 5, // Controls the shadow depth
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(HsDimens.radius8),
                  child: Image.network(
                    propertyImage,
                    width: HsDimens.size110,
                    height: HsDimens.size110,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: HsDimens.spacing16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          propertyType,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.primary),
                        ),
                        const SizedBox(
                          height: HsDimens.spacing4,
                        ),
                        Text(propertyName,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontStyleGuide.fwBold,
                                )),
                        const SizedBox(
                          height: HsDimens.spacing4,
                        ),
                        Text(state,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: HSColor.neutral6)),
                        const SizedBox(
                          height: HsDimens.spacing4,
                        ),
                        Text.rich(TextSpan(
                            text: HatSpaceStrings.current
                                .currencyFormatter(currency.symbol, price),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontSize: FontStyleGuide.fontSize18,
                                    height: 28 / 18,
                                    fontWeight: FontWeight.w700),
                            children: [
                              TextSpan(
                                  text: ' $rentingPeriod',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: HSColor.neutral6))
                            ]))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
