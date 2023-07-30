import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:intl/intl.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_buttons_settings.dart';
import 'package:hatspace/theme/widgets/hs_date_picker.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/data/property_data.dart';

class AddPropertyTypeView extends StatefulWidget {
  const AddPropertyTypeView({super.key});

  @override
  State<AddPropertyTypeView> createState() => _AddPropertyTypeViewState();
}

class _AddPropertyTypeViewState extends State<AddPropertyTypeView> {
  final ValueNotifier<PropertyTypes> _propertyType =
      ValueNotifier(PropertyTypes.house);
  final ValueNotifier<DateTime> _selectedDate = ValueNotifier(DateTime.now());

  @override
  void initState() {
    super.initState();

    _propertyType.value = context.read<AddPropertyCubit>().propertyType;
    _selectedDate.value = context.read<AddPropertyCubit>().availableDate;

    _propertyType.addListener(() {
      context.read<AddPropertyCubit>().propertyType = _propertyType.value;
    });

    _selectedDate.addListener(() {
      context.read<AddPropertyCubit>().availableDate = _selectedDate.value;
    });
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
            left: HsDimens.spacing16,
            top: HsDimens.spacing32,
            right: HsDimens.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(HatSpaceStrings.current.whatKindOfPlace,
                  style: Theme.of(context).textTheme.displayLarge),
            ),
            Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(top: HsDimens.spacing16),
                    child: Text(
                        HatSpaceStrings.current.chooseKindOfYourProperty,
                        style: Theme.of(context).textTheme.bodyMedium))),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ValueListenableBuilder<PropertyTypes>(
                      valueListenable: _propertyType,
                      builder: (context, value, child) => _PropertyTypeCardView(
                        type: PropertyTypes.house,
                        isSelected: value == PropertyTypes.house,
                        onSelected: _onPropertyTypeChanged,
                      ),
                    ),
                  ),
                  const SizedBox(width: HsDimens.spacing16),
                  Expanded(
                      child: ValueListenableBuilder<PropertyTypes>(
                    valueListenable: _propertyType,
                    builder: (context, value, child) => _PropertyTypeCardView(
                      type: PropertyTypes.apartment,
                      isSelected: value == PropertyTypes.apartment,
                      onSelected: _onPropertyTypeChanged,
                    ),
                  ))
                ],
              ),
            ),
            Flexible(
              child: Padding(
                  padding: const EdgeInsets.only(
                      top: HsDimens.spacing20, bottom: HsDimens.spacing4),
                  child: Text(HatSpaceStrings.current.availableDate,
                      style: Theme.of(context).textTheme.bodyMedium)),
            ),
            // Show DatePicker Widget;
            ValueListenableBuilder<DateTime>(
              valueListenable: _selectedDate,
              builder: (context, value, child) => _DatePickerView(
                selectedDate: value,
                onSelectedDate: (value) {
                  _selectedDate.value = value;
                },
              ),
            ),
          ],
        ),
      );

  void _onPropertyTypeChanged(PropertyTypes type) => _propertyType.value = type;

  @override
  void dispose() {
    _selectedDate.dispose();
    _propertyType.dispose();

    super.dispose();
  }
}

class _PropertyTypeCardView extends StatelessWidget {
  final PropertyTypes type;
  final bool isSelected;
  final ValueChanged<PropertyTypes> onSelected;

  const _PropertyTypeCardView(
      {required this.type,
      required this.isSelected,
      required this.onSelected,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.only(top: HsDimens.spacing20),
      elevation: 6,
      color: isSelected ? HSColor.accent : HSColor.neutral2,
      shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1.5,
              color: isSelected ? HSColor.onAccent : Colors.transparent),
          borderRadius: BorderRadius.circular(HsDimens.radius8)),
      child: InkWell(
        borderRadius: BorderRadius.circular(HsDimens.radius8),
        onTap: () => onSelected(type),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: HsDimens.spacing16, vertical: HsDimens.spacing24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(type.getIconPath(),
                  width: HsDimens.size48, height: HsDimens.size48),
              const SizedBox(
                height: HsDimens.spacing16,
              ),
              Text(type.displayName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: FontStyleGuide.fontSize16,
                      fontWeight: FontWeight.w700))
            ],
          ),
        ),
      ));
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
