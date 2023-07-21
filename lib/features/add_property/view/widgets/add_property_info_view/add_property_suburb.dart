import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';

enum ErrorType {
  isEmpty(true),
  maxLength(false),
  hasInvalidCharacters(false);

  final bool isPersistent;

  const ErrorType(this.isPersistent);
}

class AddPropertySuburbView extends StatefulWidget {
  const AddPropertySuburbView({super.key});

  @override
  State<AddPropertySuburbView> createState() => _AddPropertySuburbViewState();
}

class _AddPropertySuburbViewState extends State<AddPropertySuburbView> with AutomaticKeepAliveClientMixin<AddPropertySuburbView>{
  final FocusNode _suburbFocusNode = FocusNode();
  final FocusNode _postalCodeFocusNode = FocusNode();

  final ValueNotifier<ErrorType?> _suburbErrorType = ValueNotifier(null);
  final ValueNotifier<ErrorType?> _postalErrorType = ValueNotifier(null);

  @override
  void initState() {
    super.initState();

    _suburbFocusNode.addListener(() {
      if (!_suburbFocusNode.hasFocus) {
        ErrorType? error = _suburbErrorType.value;

        if (error != null && !error.isPersistent) {
          _suburbErrorType.value = null;
        } else if (context.read<AddPropertyCubit>().suburb.isEmpty) {
          _suburbErrorType.value = ErrorType.isEmpty;
        }
      }
    });

    _postalCodeFocusNode.addListener(() {
      if (!_postalCodeFocusNode.hasFocus) {
        ErrorType? error = _postalErrorType.value;

        if (error != null && !error.isPersistent) {
          _postalErrorType.value = null;
        } else if (context.read<AddPropertyCubit>().postalCode == null) {
          _postalErrorType.value = ErrorType.isEmpty;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: ValueListenableBuilder<ErrorType?>(
          valueListenable: _suburbErrorType,
          builder: (context, value, child) => HatSpaceInputText(
            errorText: value?.suburbError,
            focusNode: _suburbFocusNode,
            label: HatSpaceStrings.current.suburb,
            isRequired: true,
            placeholder: HatSpaceStrings.current.enterYourSuburb,
            inputFormatters: [SuburbTextInputFormatter(_suburbErrorType)],
            onChanged: (value) {
              context.read<AddPropertyCubit>().suburb = value;
            },
          ),
        )),
        const SizedBox(width: HsDimens.spacing16),
        Expanded(
            child: ValueListenableBuilder<ErrorType?>(
          valueListenable: _postalErrorType,
          builder: (context, value, child) => HatSpaceInputText(
            errorText: value?.postalError,
            focusNode: _postalCodeFocusNode,
            label: HatSpaceStrings.current.postcode,
            isRequired: true,
            placeholder: HatSpaceStrings.current.enterYourPostcode,
            inputFormatters: [PostalCodeTextInputFormatter(_postalErrorType)],
            onChanged: (value) {
              context.read<AddPropertyCubit>().postalCode = int.tryParse(value);
            },
          ),
        ))
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SuburbTextInputFormatter extends TextInputFormatter {
  ValueNotifier<ErrorType?> error;

  SuburbTextInputFormatter(this.error);
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text == oldValue.text) {
      // no change
      return newValue;
    }

    if (newValue.text.isEmpty) {
      error.value = ErrorType.isEmpty;
      return newValue;
    }

    if (newValue.text.length > ErrorType.maxLength.maxSuburbCharCount) {
      error.value = ErrorType.maxLength;
      return oldValue;
    }

    RegExp regExp = RegExp(r'^[A-Za-z .,]+$');
    if (!regExp.hasMatch(newValue.text)) {
      error.value = ErrorType.hasInvalidCharacters;
      return oldValue;
    }

    error.value = null;
    return newValue;
  }
}

class PostalCodeTextInputFormatter extends TextInputFormatter {
  final ValueNotifier<ErrorType?> error;

  PostalCodeTextInputFormatter(this.error);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text == oldValue.text) {
      // no change
      return newValue;
    }

    if (newValue.text.isEmpty) {
      error.value = ErrorType.isEmpty;
      return newValue;
    }

    if (newValue.text.length > ErrorType.maxLength.maxPostalCharCount) {
      error.value = ErrorType.maxLength;
      return oldValue;
    }

    RegExp regExp = RegExp(r'^[0-9]+$');

    if (!regExp.hasMatch(newValue.text)) {
      error.value = ErrorType.hasInvalidCharacters;
      return oldValue;
    }

    error.value = null;
    return newValue;
  }
}

/// extensions
extension SuburbErrorText on ErrorType {
  String get suburbError {
    switch (this) {
      case ErrorType.isEmpty:
        return HatSpaceStrings.current.enterSuburb;
      case ErrorType.hasInvalidCharacters:
        return HatSpaceStrings.current.textWithInvalidChars;
      case ErrorType.maxLength:
        return HatSpaceStrings.current.maximumChars(maxSuburbCharCount);
    }
  }

  int get maxSuburbCharCount => 40;
}

extension PostalErrorText on ErrorType {
  String get postalError {
    switch (this) {
      case ErrorType.isEmpty:
        return HatSpaceStrings.current.enterPostalCode;
      case ErrorType.hasInvalidCharacters:
        return HatSpaceStrings.current.numberFieldContainsNonNumber;
      case ErrorType.maxLength:
        return HatSpaceStrings.current.maximumChars(maxPostalCharCount);
    }
  }

  int get maxPostalCharCount => 10;
}
