import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/gen/assets.gen.dart';

import 'hs_theme.dart';

const containerPadding =
    EdgeInsets.only(top: 12, bottom: 12, left: 24, right: 24);
const toastWidth = 343.0;
const toastBorder = BorderRadius.all(Radius.circular(4));
TextStyle? toastTextStyle = textTheme.bodyMedium
    ?.copyWith(color: colorScheme.onSurface, decoration: TextDecoration.none);
RoundedRectangleBorder ToastStyle = const RoundedRectangleBorder(
    side: BorderSide(style: BorderStyle.solid, width: 1),
    borderRadius: BorderRadius.all(Radius.circular(4)));

class ToastMessageSuccess extends StatelessWidget {
  final String message;
  const ToastMessageSuccess({super.key, required this.message});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      child: Card(
          key: Key(message),
          color: HSColor.statusSuccess.withOpacity(0.3),
          shape: ToastStyle.copyWith(
              side: ToastStyle.side.copyWith(color: HSColor.statusSuccess)),
          child: Padding(
            padding: containerPadding,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: SvgPicture.asset(
                      key: const Key("icon"),
                      Assets.images.tickCircle,
                      color: HSColor.primary,
                    )),
                Expanded(flex: 5, child: Text(message, style: toastTextStyle))
              ],
            ),
          )),
    );
  }
}

class ToastMessageError extends StatelessWidget {
  final String message;
  const ToastMessageError({super.key, required this.message});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      child: Card(
          key: Key(message),
          color: HSColor.statusError.withOpacity(0.3),
          shape: ToastStyle.copyWith(
              side: ToastStyle.side.copyWith(color: HSColor.statusError)),
          child: Padding(
            padding: containerPadding,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: SvgPicture.asset(
                      Assets.images.closeCircle,
                      color: HSColor.statusError,
                    )),
                Expanded(flex: 5, child: Text(message, style: toastTextStyle))
              ],
            ),
          )),
    );
  }
}

class ToastMessageInfo extends StatelessWidget {
  final String message;
  const ToastMessageInfo({super.key, required this.message});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      child: Card(
          key: Key(message),
          color: HSColor.statusInformational.withOpacity(0.3),
          shape: ToastStyle.copyWith(
              side:
                  ToastStyle.side.copyWith(color: HSColor.statusInformational)),
          child: Padding(
            padding: containerPadding,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: SvgPicture.asset(
                      Assets.images.infoCircle,
                      color: HSColor.statusInformational,
                    )),
                Expanded(flex: 5, child: Text(message, style: toastTextStyle))
              ],
            ),
          )),
    );
  }
}

class ToastMessageWarning extends StatelessWidget {
  final String message;
  const ToastMessageWarning({super.key, required this.message});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      child: Card(
          key: Key(message),
          color: HSColor.statusWarning.withOpacity(0.3),
          shape: ToastStyle.copyWith(
              side: ToastStyle.side.copyWith(color: HSColor.statusWarning)),
          child: Padding(
            padding: containerPadding,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: SvgPicture.asset(
                      Assets.images.danger,
                      color: HSColor.statusWarning,
                    )),
                Expanded(flex: 5, child: Text(message, style: toastTextStyle))
              ],
            ),
          )),
    );
  }
}
