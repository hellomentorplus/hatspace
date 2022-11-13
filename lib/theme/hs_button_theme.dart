import 'package:flutter/material.dart';
import 'package:hatspace/theme/hs_theme.dart';

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
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return HSColor.onPrimary;
          }
        }),
        padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.only(top: 17, bottom: 17)),
        shape: MaterialStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)))));

OutlinedButtonThemeData secondaryButtonTheme = OutlinedButtonThemeData(
  style: ButtonStyle(
      textStyle: MaterialStatePropertyAll(
          textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
      fixedSize: const MaterialStatePropertyAll<Size>(Size.fromWidth(343)),
      alignment: Alignment.center,
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.only(top: 17, bottom: 17)),
      shape: MaterialStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      side: MaterialStateBorderSide.resolveWith(
        (states) {
          // Disabled EVENT
          if (states.contains(MaterialState.disabled)) {
            return const BorderSide(color: HSColor.neutral3);
          } else {
            return const BorderSide(color: HSColor.primary);
          }
        },
        // TODO: TextStyle - as soon as Tai push text theme
      )),
);

TextButtonThemeData textOnlyButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
  textStyle: MaterialStatePropertyAll(
      textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
));

ElevatedButtonThemeData buttonWithIconTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
        fixedSize: const MaterialStatePropertyAll<Size>(Size.fromWidth(343)),
        alignment: Alignment.center,
        textStyle: MaterialStatePropertyAll(
            textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          //=====DISABLED EVENT
          if (states.contains(MaterialState.disabled)) {
            return HSColor.neutral3;
          } else {
            return HSColor.neutral3;
          }
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return HSColor.onPrimary;
          } else {
            return HSColor.onSurface;
          }
        }),
        padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.only(top: 17, bottom: 17)),
        shape: MaterialStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)))));

OutlinedButtonThemeData secondaryButtonWithIconTheme = OutlinedButtonThemeData(
    style: ButtonStyle(
  textStyle: MaterialStatePropertyAll(
      textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
  alignment: Alignment.center,
  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.only(top: 17, bottom: 17)),
  shape: MaterialStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
  side: const MaterialStatePropertyAll<BorderSide>(
      BorderSide(color: HSColor.neutral5)),
  foregroundColor: MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.disabled)) {
      return HSColor.neutral3;
    }
    return HSColor.onSurface;
  }),
));
