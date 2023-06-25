import 'package:flutter/material.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_warning_bottom_sheet.dart';

extension HsBottomSheet on BuildContext {
  showLoginModal(
      {required VoidCallback primaryOnPressed,
      required VoidCallback secondaryOnPressed}) {
    return showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(8.0),
          ),
        ),
        context: this,
        builder: (_) {
          return SingleChildScrollView(
              child: HsWarningBottomSheetView(
            iconUrl: Assets.images.loginCircle,
            title: HatSpaceStrings.current.login,
            description: HatSpaceStrings.current.loginDescription,
            primaryButtonLabel: HatSpaceStrings.current.yesLoginNow,
            primaryOnPressed: primaryOnPressed,
            secondaryButtonLabel: HatSpaceStrings.current.noLater,
            secondaryOnPressed: secondaryOnPressed,
          ));
        });
  }

  void dismissLoading() {
    Navigator.of(this, rootNavigator: true).pop();
  }
}
