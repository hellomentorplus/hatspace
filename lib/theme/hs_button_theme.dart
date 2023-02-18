import 'package:flutter/material.dart';
import 'package:hatspace/theme/hs_theme.dart';

EdgeInsets padding = const EdgeInsets.only(top: 17, bottom: 17);

BorderRadius borderRadius = BorderRadius.circular(8);
ElevatedButtonThemeData primaryButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
        alignment: Alignment.center,
        textStyle: MaterialStatePropertyAll(
            textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          //=====DISABLED EVENT
          if (states.contains(MaterialState.disabled)) {
            return HSColor.neutral3;
          } else {
            return HSColor.primary;
          }
        }),
        foregroundColor:
            const MaterialStatePropertyAll<Color>(HSColor.onPrimary),
        padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(padding),
        shape: MaterialStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: borderRadius))));

OutlinedButtonThemeData secondaryButtonTheme = OutlinedButtonThemeData(
  style: ButtonStyle(
      textStyle: MaterialStatePropertyAll(
          textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
      alignment: Alignment.center,
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(padding),
      shape: MaterialStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: borderRadius)),
      side: MaterialStateBorderSide.resolveWith(
        (states) {
          // Disabled EVENT
          if (states.contains(MaterialState.disabled)) {
            return const BorderSide(color: HSColor.neutral3);
          } else {
            return const BorderSide(color: HSColor.primary);
          }
        },
      )),
);

TextButtonThemeData textOnlyButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
  foregroundColor: MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.disabled)) {
      return HSColor.neutral3;
    }
    return HSColor.onSurface;
  }),
  textStyle: MaterialStatePropertyAll(textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w700, decoration: TextDecoration.underline)),
));

ElevatedButtonThemeData buttonWithIconTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
        alignment: Alignment.center,
        textStyle: MaterialStatePropertyAll(
            textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          //=====DISABLED EVENT
          if (states.contains(MaterialState.disabled)) {
            return HSColor.neutral3;
          } else {
            return HSColor.neutral4;
          }
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return HSColor.onPrimary;
          } else {
            return HSColor.onSurface;
          }
        }),
        padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(padding),
        shape: MaterialStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: borderRadius))));

OutlinedButtonThemeData secondaryButtonWithIconTheme = OutlinedButtonThemeData(
    style: ButtonStyle(
  textStyle: MaterialStatePropertyAll(
      textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
  alignment: Alignment.center,
  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(padding),
  shape: MaterialStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: borderRadius)),
  side: const MaterialStatePropertyAll<BorderSide>(
      BorderSide(color: HSColor.neutral3)),
  foregroundColor: MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.disabled)) {
      return HSColor.neutral3;
    }
    return HSColor.onSurface;
  }),
));
