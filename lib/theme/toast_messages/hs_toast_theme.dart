import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/toast_messages/toast_messages.dart';

const _MAX_LENGTH = 160;
const _MAX_LINES = 2;

enum ToastType {
  errorToast(
      //TODO: Replace fixed icon path
      backgroundColor: Color.fromARGB(255, 255, 241, 241),
      icon: "assets/images/error.svg",
      closeIcon: "assets/images/close-clear.svg");

  final Color backgroundColor;
  final String icon;
  final String closeIcon;
  const ToastType(
      {required this.backgroundColor,
      required this.icon,
      required this.closeIcon});
}

class ToastMessageContainer extends StatelessWidget {
  final ToastType toastType;
  final String toastTitle;
  final String toastContent;
  // final ToastTypeTest toastTypeTest;
  const ToastMessageContainer({
    super.key,
    required this.toastType,
    required this.toastTitle,
    required this.toastContent,
    // required this.toastTypeTest,
  })  : assert(toastContent.length < _MAX_LENGTH,
            "Toast content from `$toastContent` must not over 160 characters"),
        assert(toastTitle.length < _MAX_LENGTH,
            "Toast title `$toastTitle must not over 160 charaters ");
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: toastType.backgroundColor),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              toastType.icon,
              width: 24,
              height: 24,
            ),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          toastTitle,
                          maxLines: _MAX_LINES,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xff141414),
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            context.closeToast();
                          },
                          child: SvgPicture.asset(
                            toastType.closeIcon,
                            width: 24,
                            height: 24,
                          ))
                    ],
                  ),
                  Text(toastContent,
                      overflow: TextOverflow.ellipsis,
                      maxLines: _MAX_LINES,
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
