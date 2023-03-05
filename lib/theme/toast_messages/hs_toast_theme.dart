import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/toast_messages/toast_messages.dart';

class ToastMessageError extends StatelessWidget {
  final String message;
  final String title;
  const ToastMessageError(
      {super.key, required this.message, required this.title});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ToastMessageContainer(
        key: key,
        backgroundColor: const Color.fromARGB(255, 255, 241, 241),
        icon: SvgPicture.asset(Assets.images.error),
        toastTitle: title,
        toastContent: message);
  }
}

class ToastMessageContainer extends StatelessWidget {
  final Color backgroundColor;
  final SvgPicture icon;
  SvgPicture? closeIcon;
  Key? key;
  String toastTitle;
  String toastContent;
  ToastMessageContainer(
      {super.key,
      required this.backgroundColor,
      required this.icon,
      required this.toastTitle,
      required this.toastContent,
      this.closeIcon})
      : assert(toastContent.length < 160,
            "Toast content from `$toastContent` must not over 160 characters"),
        assert(toastTitle.length < 160,
            "Toast title `$toastTitle must not over 160 charaters ");
  @override
  Widget build(BuildContext context) {
    return Container(
        key: key,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: backgroundColor),
        width: 343,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            icon,
            Flexible(
                child: Padding(
              padding: const EdgeInsets.only(left: 13.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          toastTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xfff141414),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ToastMessages().closeToast(context);
                        },
                        child: closeIcon ??=
                            SvgPicture.asset(Assets.images.closeClear),
                      )
                    ],
                  ),
                  Text(toastContent,
                      maxLines: 2,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xfff383838))),
                ],
              ),
            )),
          ],
        ));
  }
}
