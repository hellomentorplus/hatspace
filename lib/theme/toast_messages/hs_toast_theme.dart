import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/toast_messages/toast_messages_extension.dart';

const maxLength = 160;
const maxLines = 2;
// TODO: Need to update when having update new theme
double containerPadding = 12.0;
double iconSize = 24.0;

enum ToastType {
  errorToast(backgroundColor: Color.fromARGB(255, 255, 241, 241));

  final Color backgroundColor;
  String get icon => _getIcon();
  String get closeIcon => _getCloseIcon();

  const ToastType({required this.backgroundColor});

  String _getIcon() {
    switch (this) {
      case ToastType.errorToast:
        return Assets.images.error;
    }
  }

  String _getCloseIcon() {
    switch (this) {
      case ToastType.errorToast:
        return Assets.images.closeIcon;
    }
  }
}

class ToastMessageContainer extends StatelessWidget {
  final ToastType toastType;
  final String toastTitle;
  final String toastContent;
  const ToastMessageContainer({
    super.key,
    required this.toastType,
    required this.toastTitle,
    required this.toastContent,
  })  : assert(toastContent.length <= maxLength,
            "Toast content from `$toastContent` must not over 160 characters"),
        assert(toastTitle.length <= maxLength,
            "Toast title `$toastTitle must not over 160 charaters ");
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(containerPadding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: toastType.backgroundColor),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              toastType.icon,
              width: iconSize,
              height: iconSize,
            ),
            Flexible(
                child: Padding(
              padding: EdgeInsets.only(left: containerPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          toastTitle,
                          maxLines: maxLines,
                          overflow: TextOverflow.ellipsis,
                          // TODO: TextStyle-Color need to be updated when new theme released
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xff141414),
                          ),
                        ),
                      ),
                      GestureDetector(
                          key: const Key("closeTap"),
                          onTap: () {
                            context.closeToast();
                          },
                          child: SvgPicture.asset(
                            toastType.closeIcon,
                            width: iconSize,
                            height: iconSize,
                          ))
                    ],
                  ),
                  Text(toastContent,
                      overflow: TextOverflow.ellipsis,
                      maxLines: maxLines,
                      // TODO: TextStyle-Color need to be updated when new theme released
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xff383838))),
                ],
              ),
            )),
          ],
        ));
  }
}
