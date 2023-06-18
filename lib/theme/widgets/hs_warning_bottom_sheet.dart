import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

class HsWarningBottomSheetView extends StatelessWidget {
  // final ValueChanged value;
  final String? iconUrl;
  final String title;
  final String description;
  final bool enablePrimaryButton;
  final String primaryButtonLabel; // return false value
  final VoidCallback? primaryOnPressed;
  final bool enableSecondaryButton;
  final String secondaryButtonLabel; // return true value
  final VoidCallback? secondaryOnPressed;
  const HsWarningBottomSheetView(
      {super.key,
      // required this.value,
      this.iconUrl,
      String? title,
      String? description,
      String? primaryButtonLabel,
      bool? enablePrimaryButton,
      this.primaryOnPressed,
      bool? enableSecondaryButton,
      String? secondaryButtonLabel,
      this.secondaryOnPressed})
      : title = title ?? "Modal title",
        description = description ?? "Modal description",
        enablePrimaryButton = enablePrimaryButton ?? false,
        primaryButtonLabel = primaryButtonLabel ?? "",
        enableSecondaryButton = enableSecondaryButton ?? false,
        secondaryButtonLabel = secondaryButtonLabel ?? "";
  @override
  Widget build(BuildContext context) {
    List<Widget> modalContent = [];
    List<Widget> buttonGroup = [];
    Widget button;
    // TODO: implement build
    if (iconUrl == null) {
      modalContent = [
        Text(title, style: textTheme.displayLarge?.copyWith(fontSize: 18.0)),
        const SizedBox(height: HsDimens.spacing4),
        Text(
          description,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          textAlign: TextAlign.center,
        )
      ];
    } else {
      modalContent = [
        SvgPicture.asset(iconUrl!),
        const SizedBox(
          height: HsDimens.spacing24,
        ),
        Text(title, style: textTheme.displayLarge?.copyWith(fontSize: 18.0)),
        const SizedBox(height: HsDimens.spacing4),
        Text(
          description,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          textAlign: TextAlign.center,
        )
      ];
    }

    if (enablePrimaryButton) {
      button = Padding(
          padding: const EdgeInsets.only(bottom: HsDimens.spacing16),
          child: PrimaryButton(
              label: primaryButtonLabel,
              onPressed: () {
                // TODO; close bottom sheet, no data save
                primaryOnPressed!();
              }));
      buttonGroup.add(button);
    }
    if (enableSecondaryButton) {
      button = Padding(
          padding: const EdgeInsets.only(bottom: HsDimens.spacing16),
          child: SecondaryButton(
              label: secondaryButtonLabel,
              onPressed: () {
                // TODO; close bottom sheet, no data save
                secondaryOnPressed!();
              }));
      buttonGroup.add(button);
    }
    return Padding(
        key: key,
        padding: const EdgeInsets.symmetric(
            vertical: HsDimens.spacing32, horizontal: HsDimens.spacing24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(children: modalContent),
            const SizedBox(height: HsDimens.spacing24),
            // Button group
            Column(
              children: buttonGroup,
            )
          ],
        ));
  }
}