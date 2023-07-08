import 'package:flutter/material.dart';
import 'package:hatspace/dimens/hs_dimens.dart';

import 'package:hatspace/theme/widgets/hs_warning_bottom_sheet.dart';

extension HsBottomSheet on BuildContext {
  Future<bool?> showHsBottomSheet(
      HsWarningBottomSheetView hsWarningBottomSheetView) {
    return showModalBottomSheet<bool>(
        useSafeArea: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(HsDimens.radius16),
          ),
        ),
        context: this,
        builder: (_) {
          return SingleChildScrollView(child: hsWarningBottomSheetView);
        });
  }
}
