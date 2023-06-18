import 'package:flutter/material.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_warning_bottom_sheet.dart';

extension BottomModalExtension on BuildContext {
  Future<void> showLoginModal(
      {required VoidCallback primaryOnPressed,
      required VoidCallback secondaryOnPressed}) {
    return showModalBottomSheet(
        context: this,
        builder: (_) {
          return Wrap(
            children: [
              HsWarningBottomSheetView(
                  iconUrl: Assets.images.loginCircle,
                  title: HatSpaceStrings.current.login,
                  description: HatSpaceStrings.current.neeTobeLoggedInToView,
                  enablePrimaryButton: true,
                  primaryButtonLabel: HatSpaceStrings.current.yesLoginNow,
                  primaryOnPressed: primaryOnPressed,
                  enableSecondaryButton: true,
                  secondaryButtonLabel: HatSpaceStrings.current.noLater,
                  secondaryOnPressed: secondaryOnPressed)
            ],
          );
        });
  }

  void dismissLoading() {
    Navigator.of(this, rootNavigator: true).pop();
  }
}
