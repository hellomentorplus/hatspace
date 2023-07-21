import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

enum ErrorType {
  nameIsEmpty(true),
  nameExceed30Chars(false),
  nameContainsInvalidChars(false);

  final bool isPersistent;
  final int maxCharCount = 30;

  const ErrorType(this.isPersistent);

  String get text {
    switch (this) {
      case ErrorType.nameIsEmpty:
        return HatSpaceStrings.current.enterPropertyName;
      case ErrorType.nameExceed30Chars:
        return HatSpaceStrings.current.maximumChars(maxCharCount);
      case ErrorType.nameContainsInvalidChars:
        return HatSpaceStrings.current.textWithInvalidChars;
    }
  }

  bool check(String name) {
    switch (this) {
      case ErrorType.nameIsEmpty:
        return name.isEmpty;
      case ErrorType.nameExceed30Chars:
        return name.length > maxCharCount;
      case ErrorType.nameContainsInvalidChars:
        RegExp regExp = RegExp(r'^[A-Za-z .,0-9]+$');
        return !regExp.hasMatch(name);
    }
  }
}

class AddPropertyNameView extends StatefulWidget {
  const AddPropertyNameView({super.key});

  @override
  State<AddPropertyNameView> createState() => _AddPropertyNameViewState();
}

class _AddPropertyNameViewState extends State<AddPropertyNameView> {
  final ValueNotifier<ErrorType?> _error = ValueNotifier(null);
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        ErrorType? error = _error.value;

        if (error != null && !error.isPersistent) {
          _error.value = null;
        } else if (ErrorType.nameIsEmpty
            .check(context.read<AddPropertyCubit>().propertyName)) {
          _error.value = ErrorType.nameIsEmpty;
        }
      }
    });
  }

  @override
  void dispose() {
    _error.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _error,
      builder: (context, error, child) => HatSpaceInputText(
        focusNode: _focusNode,
        errorText: error?.text,
        label: HatSpaceStrings.current.propertyName,
        isRequired: true,
        placeholder: HatSpaceStrings.current.enterPropertyName,
        inputFormatters: [PropertyNameInputFormatter(_error)],
        onChanged: (value) {
          context.read<AddPropertyCubit>().propertyName = value;
        },
      ),
    );
  }
}

class PropertyNameInputFormatter extends TextInputFormatter {
  final ValueNotifier<ErrorType?> _error;

  PropertyNameInputFormatter(this._error);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (oldValue.text == newValue.text) {
      // nothing change
      return newValue;
    }

    if (ErrorType.nameIsEmpty.check(newValue.text)) {
      _error.value = ErrorType.nameIsEmpty;
      return newValue;
    }

    if (ErrorType.nameExceed30Chars.check(newValue.text)) {
      _error.value = ErrorType.nameExceed30Chars;
      return oldValue;
    }

    if (ErrorType.nameContainsInvalidChars.check(newValue.text)) {
      _error.value = ErrorType.nameContainsInvalidChars;
      return oldValue;
    }

    _error.value = null;
    return newValue;
  }
}
