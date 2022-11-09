import 'package:flutter/material.dart';

ElevatedButtonThemeData defaultPrimaryTextOnlyButtonTheme =
    ElevatedButtonThemeData(
        style: ButtonStyle(
  alignment: Alignment.center,
  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff3ACD64)),
  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.fromLTRB(22, 17, 39, 17)),
  shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));
  }),
));

OutlinedButtonThemeData defaultSecondaryTextOnlyButtonTheme =
    OutlinedButtonThemeData(
        style: ButtonStyle(
  alignment: Alignment.center,
  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.fromLTRB(22, 17, 39, 17)),
  shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));
  }),
  side: MaterialStateBorderSide.resolveWith((_){
    return const BorderSide(
      color: Color(0xff3ACD64)
    );
  })
));

ElevatedButtonThemeData disablePrimaryTextOnlyButtonTheme =
    ElevatedButtonThemeData(
        style: ButtonStyle(
  alignment: Alignment.center,
  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xffD1D1D6)),
  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.fromLTRB(22, 17, 39, 17)),
  shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));
  }),
//         side: MaterialStateBorderSide.resolveWith((_) {
//           return const BorderSide(color: Colors.black87);
// })
));

TextButtonThemeData defaultTextOnlyButtonTheme = 
    TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            color: Colors.white,
            fontSize: 26,
            decoration: TextDecoration.underline
          )
        )
        )
    );


