import 'package:flutter/material.dart';
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
                        Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const PrimaryButton(
                                      label: 'AUS (+61)',
                                      style: ButtonStyle(
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
                                      child: HatSpaceInputText(
                                    label: '',
                                    onChanged: (value) {
                                      // TODO: set phone number here
                                    },
                                    placeholder: HatSpaceStrings
                                        .current.updatePhonePlaceHolder,              
                                  ))
                                ],
                          )
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
                        child:  PrimaryButton(
                                label: HatSpaceStrings.current.save,
                                onPressed: (){
                                  // TODO: Upload value to database 
                                })
                        ))
              ],
            )));
  }
}