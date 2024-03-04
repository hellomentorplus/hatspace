import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';

class UpdatePhoneNoBottomSheetView extends StatefulWidget {
  const UpdatePhoneNoBottomSheetView({super.key});
  @override
  State<StatefulWidget> createState() => _UpdatePhoneNoBottomSheet();
}

class _UpdatePhoneNoBottomSheet extends State<UpdatePhoneNoBottomSheetView> {
  final ValueNotifier<PhoneNumberErrorType?> _phoneNumberError =
      ValueNotifier(null);
  late String phoneNumber;

  @override
  void dispose() {
    _phoneNumberError.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        heightFactor: 0.95,
        child: Padding(
            padding: const EdgeInsets.only(bottom: HsDimens.spacing40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.only(
                        bottom: HsDimens.spacing8, top: HsDimens.spacing24),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: HSColor.neutral2))),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                            right: HsDimens.spacing24,
                            child: IconButton(
                              icon: SvgPicture.asset(Assets.icons.closeIcon),
                              onPressed: () => context.pop(),
                            )),
                        Center(
                            child: Text((HatSpaceStrings.current.updateProfile),
                                style: textTheme.displayLarge?.copyWith(
                                    fontSize: FontStyleGuide.fontSize16)))
                      ],
                    )),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: HsDimens.spacing24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            HatSpaceStrings.current.phoneNumber,
                          ),
                          Text(HatSpaceStrings.current.updatePhoneLabel,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: HSColor.neutral6)),
                          const SizedBox(height: HsDimens.spacing4),
                          ValueListenableBuilder<PhoneNumberErrorType?>(
                            valueListenable: _phoneNumberError,
                            builder: (context, value, child) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PrimaryButton(
                                      label: HatSpaceStrings
                                          .current.countryCode,
                                      style: const ButtonStyle(
                                          alignment: Alignment.centerLeft,
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  HSColor.neutral10),
                                          textStyle: MaterialStatePropertyAll<
                                                  TextStyle>(
                                              TextStyle(
                                                  fontSize:
                                                      FontStyleGuide.fontSize14,
                                                  fontWeight: FontWeight.w400,
                                                  color: HSColor.neutral9)))),
                                  const SizedBox(width: HsDimens.spacing24),
                                  Expanded(
                                      child: TextFormField(
                                    key: const Key('phoneNo'),
                                    onChanged: (value) {
                                      setState(() {
                                        phoneNumber = value;
                                      });
                                    },
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(height: 1.5),
                                    decoration: inputTextTheme.copyWith(
                                      focusedBorder: value?.phoneNumberError !=
                                              null
                                          ? const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: HSColor.red05,
                                                width: HsDimens.size2,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      HsDimens.radius8)))
                                          : null,
                                      hintText: HatSpaceStrings
                                          .current.updatePhonePlaceHolder,
                                      suffixIcon:
                                          value?.phoneNumberError != null
                                              ? Padding(
                                                  padding: const EdgeInsets.all(
                                                      HsDimens.spacing12),
                                                  child: SvgPicture.asset(
                                                    Assets.icons.textFieldError,
                                                    width: HsDimens.size24,
                                                    height: HsDimens.size24,
                                                  ),
                                                )
                                              : null,
                                      // when external suffix icon is available, use default constraint
                                      suffixIconConstraints:
                                          value?.phoneNumberError == null
                                              ? null
                                              : const BoxConstraints(
                                                  maxHeight: HsDimens.size48,
                                                  maxWidth: HsDimens.size48,
                                                ),
                                    ),
                                    inputFormatters: [
                                      PhoneNumberInputFormatter(
                                          _phoneNumberError),
                                    ],
                                    keyboardType: TextInputType.number,
                                  ))
                                ],
                              );
                            },
                          ),
                          ValueListenableBuilder(
                              valueListenable: _phoneNumberError,
                              builder: (context, value, child) {
                                if (value?.phoneNumberError == null) {
                                  return const SizedBox.shrink();
                                }
                                return Text(value!.phoneNumberError,
                                    style: textTheme.bodySmall?.copyWith(
                                      color: HSColor.red05,
                                    ));
                              })
                        ],
                      )),
                ),
                Container(
                    decoration: const BoxDecoration(
                        border:
                            Border(top: BorderSide(color: HSColor.neutral2))),
                    child: Padding(
                        padding: const EdgeInsets.only(
                            top: HsDimens.spacing8,
                            left: HsDimens.spacing16,
                            right: HsDimens.spacing16),
                        child: ValueListenableBuilder<PhoneNumberErrorType?>(
                          valueListenable: _phoneNumberError,
                          builder: (context, value, child) {
                            return PrimaryButton(
                                label: HatSpaceStrings.current.save,
                                onPressed: value?.phoneNumberError != null
                                    ? null
                                    : () {
                                        // TODO: SAVE AND UPLOAD TO DATABASE
                                        // context
                                        //     .read<MyProfileCubit>()
                                        //     .updateProfilePhoneNumber(PhoneNumber(countryCode: CountryCallingCode.au, phoneNumber: phoneNumber));
                                      });
                          },
                        )))
              ],
            )));
  }
}

class PhoneNumberInputFormatter extends TextInputFormatter {
  final ValueNotifier<PhoneNumberErrorType?> error;

  PhoneNumberInputFormatter(this.error);
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // FORMAT PHONE NUMBER
    if (oldValue.text.length < newValue.text.length) {
      if (newValue.text.length == 5) {
        return TextEditingValue(
            text:
                '${oldValue.text.substring(0, 4)} ${newValue.text.substring(newValue.text.length - 1)}');
      }

      if (newValue.text.length == 9) {
        return TextEditingValue(
            text:
                '${oldValue.text.substring(0, 8)} ${newValue.text.substring(newValue.text.length - 1)}');
      }
    }

    // Length VALIDATION
    if (newValue.text.isEmpty ||
        newValue.text.trim().length <
            PhoneNumberErrorType.minLength.maxPhoneNumber) {
      error.value = PhoneNumberErrorType.minLength;
      return newValue;
    }
    if (newValue.text.length > PhoneNumberErrorType.minLength.maxPhoneNumber) {
      return oldValue;
    }

    // AREA CODE VALIDATION
    RegExp codeFormat = RegExp('02|03|04|05|07|08');
    if (!newValue.text.startsWith(codeFormat)) {
      error.value = PhoneNumberErrorType.wrongCode;
      return newValue;
    }
    error.value = null;
    return newValue;
  }
}

enum PhoneNumberErrorType {
  minLength(),
  wrongCode();

  const PhoneNumberErrorType();
  String get phoneNumberError {
    switch (this) {
      case PhoneNumberErrorType.minLength:
        return HatSpaceStrings.current.wrongLenghtPhongNumerErrorMessage;
      case PhoneNumberErrorType.wrongCode:
        return HatSpaceStrings.current.wrongCodeAreaErrorMessage;
    }
  }

  int get maxPhoneNumber => 12;
}
