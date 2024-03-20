import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/gen/assets.gen.dart';

final InputDecoration inputTextTheme = InputDecoration(
  contentPadding: const EdgeInsets.fromLTRB(HsDimens.spacing16,
      HsDimens.spacing12, HsDimens.spacing12, HsDimens.spacing12),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(HsDimens.radius8),
      borderSide: const BorderSide(
        color: HSColor.black,
      )),
  hintStyle:
      textTheme.bodyMedium?.copyWith(height: 1.0, color: HSColor.neutral5),
  errorMaxLines: 1,
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(HsDimens.radius8),
      borderSide: const BorderSide(
        color: HSColor.red05,
      )),
  errorStyle: textTheme.bodySmall?.copyWith(color: HSColor.red06),
);

class HsLabel extends StatelessWidget {
  final String? label;
  final bool _isRequired;
  final String? optional;
  const HsLabel({
    required this.label,
    super.key,
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
              style: textTheme.bodySmall
                  ?.copyWith(color: _isRequired ? HSColor.requiredField : null))
        ]));
  }
}

class HatSpaceInputText extends StatelessWidget {
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final String? label;
  final String? placeholder;
  final ValueChanged<String> onChanged;
  final bool? _isRequired;
  final CrossAxisAlignment _alignment;
  final EdgeInsets _padding;
  final String? optional;
  final String? errorText;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final Color? cursorColor;
  const HatSpaceInputText(
      {required this.onChanged,
      super.key,
      this.label,
      this.placeholder,
      CrossAxisAlignment? alignment,
      bool? isRequired,
      this.optional,
      EdgeInsets? padding,
      this.errorText,
      this.inputFormatters,
      this.textInputType,
      this.cursorColor,
      this.focusNode,
      this.suffixIcon})
      : _isRequired = isRequired ?? false,
        _alignment = alignment ?? CrossAxisAlignment.start,
        _padding = padding ?? const EdgeInsets.only(bottom: HsDimens.spacing4);
  @override
  Widget build(BuildContext context) {
    List<Widget> textField = [
      TextFormField(
        cursorColor: cursorColor,
        focusNode: focusNode,
        onChanged: onChanged,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
        decoration: inputTextTheme.copyWith(
          hintText: placeholder,
          errorText: errorText,
          suffixIcon: suffixIcon ??
              (errorText == null || errorText?.isEmpty == true
                  ? null
                  : Padding(
                      padding: const EdgeInsets.all(HsDimens.spacing12),
                      child: SvgPicture.asset(
                        Assets.icons.textFieldError,
                        width: HsDimens.size24,
                        height: HsDimens.size24,
                      ),
                    )),
          // when external suffix icon is available, use default constraint
          suffixIconConstraints: suffixIcon != null
              ? null
              : const BoxConstraints(
                  maxHeight: HsDimens.size48,
                  maxWidth: HsDimens.size48,
                ),
        ),
        keyboardType: textInputType,
        inputFormatters: inputFormatters,
      )
    ];
    if (label != '') {
      textField.insert(
          0,
          Padding(
              padding: _padding,
              child: HsLabel(
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
