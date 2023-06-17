import 'package:flutter/material.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

InputDecoration inputTextTheme = InputDecoration(
    contentPadding: const EdgeInsets.fromLTRB(16, 13, 12, 13),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: HSColor.black,
        )),
    hintText: HatSpaceStrings.current.pleaseEnterYourPlaceholder,
    hintStyle:
        textTheme.bodyMedium?.copyWith(height: 1.0, color: HSColor.neutral5));

class HatSpaceLabel extends StatelessWidget {
  final String label;
  final bool isRequired;
  final String? optional;
  const HatSpaceLabel({
    super.key,
    required this.label,
    required this.isRequired,
    this.optional,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RichText(
        text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            text: label,
            children: [
          TextSpan(
              text: isRequired ? " *": "",
              style: textTheme.bodyMedium
                  ?.copyWith(color: isRequired ? HSColor.requiredField : null))
        ]));
  }
}

class HatSpaceInputText extends StatelessWidget {
  final String placeholder;
  final String? optionalLabel;
  final VoidCallback onChanged;

  const HatSpaceInputText(
      {super.key,
      required this.placeholder,
      required this.onChanged,
      this.optionalLabel});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
            onChanged: (value) {
              // TODO: implement bloc
            },
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
            decoration: inputTextTheme.copyWith(hintText: placeholder))
      ],
    );
  }
}
