import 'package:flutter/material.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_warning_bottom_sheet.dart';

extension BottomModalExtension on BuildContext {
  Future<void> showWarningModal(
      {required VoidCallback primaryOnPressed,
      required VoidCallback secondaryOnPressed}) {
    return showModalBottomSheet(
        context: this,
        builder: (_) {
          return Wrap(
            children: [
              HsWarningBottomSheetView(
                  iconUrl: Assets.images.circleWarning,
                  title: HatSpaceStrings.current.lostData,
                  description: HatSpaceStrings.current.yourDataMayBeLost,
                  enablePrimaryButton: true,
                  primaryButtonLabel: HatSpaceStrings.current.no,
                  primaryOnPressed: primaryOnPressed,
                  enableSecondaryButton: true,
                  secondaryButtonLabel: HatSpaceStrings.current.yes,
                  secondaryOnPressed: secondaryOnPressed)
            ],
          );
        });
  }
}
