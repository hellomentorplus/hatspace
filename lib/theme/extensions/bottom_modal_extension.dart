import 'package:flutter/material.dart';
import 'package:hatspace/dimens/hs_dimens.dart';

import 'package:hatspace/theme/widgets/hs_warning_bottom_sheet.dart';

extension HsBottomSheet<T> on BuildContext {
  Future<T?> showHsBottomSheet(HsWarningBottomSheetView modal) {
    return showModalBottomSheet<T>(
        useSafeArea: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(HsDimens.radius16),
          ),
        ),
        context: this,
        builder: (_) {
          return SingleChildScrollView(child: modal);
        });
  }
}
