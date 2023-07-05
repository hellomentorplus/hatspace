import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

class HsWarningBottomSheetView extends StatelessWidget {
  final String? iconUrl;
  final String? title;
  final String? description;
  final String? primaryButtonLabel; // return false value
  final VoidCallback? primaryOnPressed;
  final String? secondaryButtonLabel; // return true value
  final VoidCallback? secondaryOnPressed;
  final String? textButtonLabel;
  final VoidCallback? textButtonOnPressed;
  final String? tertiaryButtonLabel;
  final VoidCallback? tertiaryButtonOnPressed;
  const HsWarningBottomSheetView({
    super.key,
    this.iconUrl,
    this.title,
    this.description,
    this.primaryButtonLabel,
    this.primaryOnPressed,
    this.secondaryButtonLabel,
    this.secondaryOnPressed,
    this.textButtonLabel,
    this.textButtonOnPressed,
    this.tertiaryButtonLabel,
    this.tertiaryButtonOnPressed,
  })  : assert(
            iconUrl != null ||
                title != null ||
                description != null ||
                primaryButtonLabel != null ||
                secondaryButtonLabel != null ||
                textButtonLabel != null ||
                tertiaryButtonLabel != null,
            'Require at least one field to enable bottom sheet'),
        // Assert on primary button
        assert(
            primaryButtonLabel != null ||
                secondaryButtonLabel != null ||
                textButtonLabel != null ||
                tertiaryButtonLabel != null,
            'hs bottom sheet need at lease one button enable');
  @override
  Widget build(BuildContext context) {
    List<Widget> modalContent = [];
    List<Widget> buttonGroup = [];
    Widget button;
    // Icon configuration
    if (title != null) {
      modalContent.add(Padding(
        padding: const EdgeInsets.only(bottom: HsDimens.spacing4),
        child: Text(title!,
            style: textTheme.displayLarge
                ?.copyWith(fontSize: FontStyleGuide.fontSize18)),
      ));
    }
    if (description != null) {
      modalContent.add(Text(description!,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          textAlign: TextAlign.center));
    }
    if (iconUrl != null) {
      Widget iconContent = Padding(
        padding: const EdgeInsets.only(bottom: HsDimens.spacing24),
        child: SvgPicture.asset(iconUrl!),
      );
      modalContent.insert(0, iconContent);
    }
    // Button Configuration
    if (primaryButtonLabel != null) {
      assert(primaryOnPressed != null, 'on pressed can not be null');
      button = Padding(
          padding: const EdgeInsets.only(bottom: HsDimens.spacing16),
          child: PrimaryButton(
              label: primaryButtonLabel ?? '',
              onPressed: () {
                primaryOnPressed!();
              }));
      buttonGroup.add(button);
    }
    if (secondaryButtonLabel != null) {
      assert(secondaryOnPressed != null, 'on pressed can not be null');
      button = Padding(
          padding: const EdgeInsets.only(bottom: HsDimens.spacing16),
          child: SecondaryButton(
              label: secondaryButtonLabel ?? '',
              onPressed: () {
                secondaryOnPressed!();
              }));
      buttonGroup.add(button);
    }
    if (textButtonLabel != null) {
      assert(textButtonOnPressed != null, 'on pressed can not be null');
      button = Padding(
          padding: const EdgeInsets.only(bottom: HsDimens.spacing16),
          child: TextOnlyButton(
              label: textButtonLabel ?? '',
              onPressed: () {
                textButtonOnPressed!();
              }));
      buttonGroup.add(button);
    }
    if (tertiaryButtonLabel != null) {
      assert(tertiaryButtonOnPressed != null, 'on pressed can not be null');
      button = Padding(
          padding: const EdgeInsets.only(bottom: HsDimens.spacing16),
          child: TertiaryButton(
              label: tertiaryButtonLabel ?? '',
              onPressed: () {
                tertiaryButtonOnPressed!();
              }));
      buttonGroup.add(button);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: HsDimens.spacing32, horizontal: HsDimens.spacing24),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: modalContent +
              [const SizedBox(height: HsDimens.spacing24)] +
              buttonGroup),
    );
  }
}
