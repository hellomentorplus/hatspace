import 'package:flutter/material.dart';
import 'package:hatspace/theme/pop_up/pop_up.dart';

extension PopUpController on BuildContext {
  Future<void> showLoading() {
    return showDialog(
        barrierDismissible: false,
        context: this,
        builder: (BuildContext buildContext) {
          return const PopUp();
        });
  }

  void dismissLoading() {
    Navigator.of(this, rootNavigator: true).pop();
  }
}
