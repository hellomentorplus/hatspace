import 'package:flutter/material.dart';
import 'package:hatspace/theme/hs_toast_theme.dart';
import 'package:hatspace/theme/hs_toast_type.dart';

class ToastMessage extends StatelessWidget {
  final String message;
  final String type;
  const ToastMessage({Key? key, required this.message, required this.type})
      : assert(message != null || type != null, "label or icon is required"),
        assert(
            type != ToastType.success ||
                type != ToastType.error ||
                type != ToastType.warning ||
                type != ToastType.info,
            "Type must have one of these value SUCCESS - ERROR - WARNING - INFO"),
        super(key: key);

  getToast(String type, String message) {
    switch (type) {
      case ToastType.success:
        {
          return ToastMessageSuccess(message: message);
        }

      case ToastType.error:
        {
          return ToastMessageError(
            message: message,
          );
        }

      case ToastType.info:
        {
          return ToastMessageInfo(message: message);
        }
      case ToastType.warning:
        {
          return ToastMessageWarning(message: message);
        }
      default:
        {
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return getToast(type, message);
  }
}
