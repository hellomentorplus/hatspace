import 'package:flutter/material.dart';
import 'package:hatspace/theme/buttons/buttonTheme.dart';

class DefaultPrimaryTextOnlyButton extends ElevatedButton {
  DefaultPrimaryTextOnlyButton(
      {Key? key, required Widget child, required Function? onClick})
      : super(
            key: key,
            onPressed: onClick!(),
            child: child,
            style: defaultPrimaryButtonTheme.style);
}

class DefaultSecondaryTextOnlyButton extends OutlinedButton {
  DefaultSecondaryTextOnlyButton(
      {Key? key, required Widget child, required Function? onClick})
      : super(
            key: key,
            onPressed: () {
              onClick!();
            },
            child: child,
            style: defaultSecondaryButtonTheme.style);
}



class DefaultTextOnlyButton extends TextButton {
  DefaultTextOnlyButton({
    Key? key,
    required Function onPressed,
    required String text,
    // FocusNode? focusNode,
    // bool autofocus = false,
    // Clip clipBehavior = Clip.none,
  }) : super(
          key: key,
          onPressed: () {
            onPressed!();
          },
          // focusNode: focusNode,
          // autofocus: autofocus,
          // clipBehavior: clipBehavior,
          child: Text(text ),
          style: defaultTextOnlyButtonTheme.style
        );
}

class DefaulSecondaryLeftIconButton extends OutlinedButton {
  DefaulSecondaryLeftIconButton({
    Key? key,
    required Function onClick,
    required String iconURL,
    required String text,
  }) : super(
            key: key,
            child: Row(
              children: [
                Image.asset(iconURL),
                Container(
                  margin: const EdgeInsets.only(left: 44),
                  child: Text(text,style: const TextStyle(color: Colors.black,fontSize: 17)) 
                )
              ],
            ),
            onPressed: () {
              onClick();
            },
            style: defaultSecondaryButtonTheme.style?.copyWith(side: MaterialStateProperty.resolveWith((_) {
              return const BorderSide(color: Color(0xffAEAEB2));
            }))
            );
}
