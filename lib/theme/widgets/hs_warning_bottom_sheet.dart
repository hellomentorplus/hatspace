import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

class HsWarningBottomSheetView extends StatelessWidget {
  // final ValueChanged value;
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
    // required this.value,
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
  });
  @override
  Widget build(BuildContext context) {
    List<Widget> modalContent = [];
    List<Widget> buttonGroup = [];
    Widget button;
    modalContent = [
      Text(title ?? 'Title',
          style: textTheme.displayLarge?.copyWith(fontSize: 18.0)),
      const SizedBox(height: HsDimens.spacing4),
      Text(
        description ?? 'Description',
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        textAlign: TextAlign.center,
      )
    ];
    if (iconUrl != null) {
      List<Widget> iconContent = [
        SvgPicture.asset(iconUrl!),
        const SizedBox(
          height: HsDimens.spacing24,
        ),
      ];
      modalContent = List.from(iconContent)..addAll(modalContent);
    }
    if (primaryButtonLabel != null) {
      button = Padding(
          padding: const EdgeInsets.only(bottom: HsDimens.spacing16),
          child: PrimaryButton(
              label: primaryButtonLabel ?? '',
              onPressed: () {
                // TODO; close bottom sheet, no data save
                primaryOnPressed!();
              }));
      buttonGroup.add(button);
    }
    if (secondaryButtonLabel != null) {
      button = Padding(
          padding: const EdgeInsets.only(bottom: HsDimens.spacing16),
          child: SecondaryButton(
              label: secondaryButtonLabel ?? '',
              onPressed: () {
                // TODO; close bottom sheet, no data save
                secondaryOnPressed!();
              }));
      buttonGroup.add(button);
    }
    if (textButtonLabel != null) {
      button = Padding(
          padding: const EdgeInsets.only(bottom: HsDimens.spacing16),
          child: TextOnlyButton(
              label: secondaryButtonLabel ?? '',
              onPressed: () {
                // TODO; close bottom sheet, no data save
                textButtonOnPressed!();
              }));
      buttonGroup.add(button);
    }
    if (tertiaryButtonLabel != null) {
      button = Padding(
          padding: const EdgeInsets.only(bottom: HsDimens.spacing16),
          child: TextOnlyButton(
              label: secondaryButtonLabel ?? '',
              onPressed: () {
                // TODO; close bottom sheet, no data save
                tertiaryButtonOnPressed!();
              }));
      buttonGroup.add(button);
    }
    return Padding(
        key: key,
        padding: const EdgeInsets.symmetric(
            vertical: HsDimens.spacing32, horizontal: HsDimens.spacing24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(children: modalContent),
            // const SizedBox(height: HsDimens.spacing24),
            // Button group
            Column(
              children: buttonGroup,
            )
          ],
        ));
  }
}
