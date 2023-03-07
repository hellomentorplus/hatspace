import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/toast_messages/toast_messages.dart';

const _MAX_LENGTH = 160;
const _MAX_LINES = 2;

// enum ToastTypeTest {
//   errorToast(
//     backgroundColor: Color.fromARGB(242, 2, 4, 5),
//     assetPath: "asset/icon" );
//   final Color backgroundColor;
//   final String assetPath;
//   const ToastTypeTest({
//     required this.backgroundColor,
//     required this.assetPath
//   });
//   // Declare cases
// }

class ToastMessageError extends StatelessWidget {
  final String message;
  final String title;
  const ToastMessageError(
      {super.key, required this.message, required this.title});
  @override
  Widget build(BuildContext context) {
    return ToastMessageContainer(
        key: key,
        backgroundColor: const Color.fromARGB(255, 255, 241, 241),
        iconPath: Assets.images.error.toString(),
        toastTitle: title,
        toastContent: message);
  }
}

class ToastMessageContainer extends StatelessWidget {
  final Color backgroundColor;
  final String iconPath;
  final String? closeIconPath;
  final String toastTitle;
  final String toastContent;
  // final ToastTypeTest toastTypeTest;
  const ToastMessageContainer(
      {super.key,
      required this.backgroundColor,
      required this.iconPath,
      required this.toastTitle,
      required this.toastContent,
      // required this.toastTypeTest,
      this.closeIconPath})
      : assert(toastContent.length < _MAX_LENGTH,
            "Toast content from `$toastContent` must not over 160 characters"),
        assert(toastTitle.length < _MAX_LENGTH,
            "Toast title `$toastTitle must not over 160 charaters ");
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: backgroundColor),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // toastTypeTest == ToastTypeTest.errorToast?
            SvgPicture.asset(
              iconPath,
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
                            color: Color(0xfff141414),
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            ToastMessages().closeToast(context);
                          },
                          child: SvgPicture.asset(
                            closeIconPath ?? Assets.images.closeClear,
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
                          color: Color(0xfff383838))),
                ],
              ),
            )),
          ],
        ));
  }
}
