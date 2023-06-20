import 'package:flutter/material.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/theme/hs_theme.dart';

final InputDecoration inputTextTheme = InputDecoration(
    contentPadding: const EdgeInsets.fromLTRB(16, 13, 12, 13),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: HSColor.black,
        )),
    hintStyle:
        textTheme.bodyMedium?.copyWith(height: 1.0, color: HSColor.neutral5));

class HatSpaceLabel extends StatelessWidget {
  final String? label;
  final bool _isRequired;
  final String? optional;
  const HatSpaceLabel({
    required this.label, super.key,
    bool? isRequired,
    this.optional,
  }) : _isRequired = isRequired ?? false;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            text: label,
            children: [
          TextSpan(
              text: _isRequired ? ' *' : optional,
              style: textTheme.bodyMedium
                  ?.copyWith(color: _isRequired ? HSColor.requiredField : null))
        ]));
  }
}

class HatSpaceInputText extends StatelessWidget {
  final String? label;
  final String? placeholder;
  final ValueChanged onChanged;
  final bool? _isRequired;
  final CrossAxisAlignment _alignment;
  final EdgeInsets _padding;
  final String? optional;
  const HatSpaceInputText(
      {required this.onChanged, super.key,
      this.label,
      this.placeholder,
      CrossAxisAlignment? alignment,
      bool? isRequired,
      this.optional,
      EdgeInsets? padding})
      : _isRequired = isRequired ?? false,
        _alignment = alignment ?? CrossAxisAlignment.start,
        _padding = padding ?? const EdgeInsets.only(bottom: HsDimens.spacing4);
  @override
  Widget build(BuildContext context) {
    List<Widget> textField = [
      TextFormField(
          onChanged: onChanged,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
          decoration: inputTextTheme.copyWith(hintText: placeholder))
    ];
    if (label != '') {
      textField.insert(
          0,
          Padding(
              padding: _padding,
              child: HatSpaceLabel(
                label: label,
                isRequired: _isRequired,
                optional: optional,
              )));
    }
    return Column(
      crossAxisAlignment: _alignment,
      children: textField,
    );
  }
}
