import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';
import 'package:intl/intl.dart';

import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';

enum ErrorType {
  priceIsEmpty(true),
  priceIsNotNumber(false);

  final bool isPersistent;

  const ErrorType(this.isPersistent);

  String get text {
    switch (this) {
      case ErrorType.priceIsEmpty:
        return HatSpaceStrings.current.enterPrice;
      case ErrorType.priceIsNotNumber:
        return HatSpaceStrings.current.numberFieldContainsNonNumber;
    }
  }
}

class AddPropertyPriceView extends StatefulWidget {
  const AddPropertyPriceView({super.key});

  @override
  State<AddPropertyPriceView> createState() => _AddPropertyPriceViewState();
}

class _AddPropertyPriceViewState extends State<AddPropertyPriceView>
    with AutomaticKeepAliveClientMixin<AddPropertyPriceView> {
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<ErrorType?> _error = ValueNotifier(null);
  final NumberFormat _numberFormat = NumberFormat('#,###.##');

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        ErrorType? error = _error.value;

        if (error != null && !error.isPersistent) {
          _error.value = null;
        } else if (context.read<AddPropertyCubit>().price == null) {
          _error.value = ErrorType.priceIsEmpty;
        }
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _error.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ValueListenableBuilder<ErrorType?>(
      valueListenable: _error,
      builder: (context, value, child) => HatSpaceInputText(
        focusNode: _focusNode,
        errorText: value?.text,
        label: HatSpaceStrings.current.price,
        isRequired: true,
        placeholder: HatSpaceStrings.current.enterYourPrice,
        suffixIcon: Padding(
            padding: const EdgeInsets.only(
                right: HsDimens.spacing8,
                left: HsDimens.spacing16,
                top: HsDimens.spacing8,
                bottom: HsDimens.spacing8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    padding: const EdgeInsets.all(HsDimens.spacing8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: HSColor.neutral2),
                    child: Text(
                        HatSpaceStrings.current.addPropertyPriceDisplay(
                            Currency.aud.name.toUpperCase(),
                            Currency.aud.symbol),
                        style: textTheme.bodySmall
                            ?.copyWith(fontWeight: FontWeight.w700))),
                const SizedBox(
                  width: HsDimens.spacing8,
                ),
                Container(
                    padding: const EdgeInsets.all(HsDimens.spacing8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: HSColor.neutral2),
                    child: Text(
                        // TODO: Update rentalPeriodUnit in cubit
                        HatSpaceStrings.current.addPropertyRentalPeriodUnit,
                        style: textTheme.bodySmall
                            ?.copyWith(fontWeight: FontWeight.w700)))
              ],
            )),
        inputFormatters: [PriceInputTextFormatter(_error, _numberFormat)],
        onChanged: (value) {
          try {
            final num number = _numberFormat.parse(value);
            context.read<AddPropertyCubit>().setPrice(price: number.toDouble());
          } catch (_) {
            context.read<AddPropertyCubit>().setPrice(price: null);
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PriceInputTextFormatter extends TextInputFormatter {
  final ValueNotifier<ErrorType?> error;
  final NumberFormat numberFormat;

  PriceInputTextFormatter(this.error, this.numberFormat);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text == oldValue.text) {
      // no change
      return newValue;
    }

    if (newValue.text.isEmpty) {
      error.value = ErrorType.priceIsEmpty;
      return newValue;
    }

    final String newText = newValue.text;
    String numberText = newText;
    String decimalText = '';

    if (newText.contains('.')) {
      numberText = newText.split('.').first;
      decimalText = newText.split('.')[1];
    }

    num number;
    try {
      number = numberFormat.parse(numberText);
    } catch (_) {
      error.value = ErrorType.priceIsNotNumber;
      return oldValue;
    }

    if (number.toInt().toString().length > 8) {
      // max digits allow
      return oldValue;
    }

    if (decimalText.isNotEmpty) {
      final RegExp regExp = RegExp(r'^[0-9]+$');
      if (!regExp.hasMatch(decimalText)) {
        error.value = ErrorType.priceIsNotNumber;
        return oldValue;
      }
    }

    error.value = null;
    String formattedNumber = numberFormat.format(number);
    if (newText.contains('.')) {
      formattedNumber = '$formattedNumber.$decimalText';
    }
    return TextEditingValue(
        text: formattedNumber,
        selection: TextSelection.collapsed(offset: formattedNumber.length));
  }
}
