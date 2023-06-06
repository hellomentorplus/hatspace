import 'package:flutter/material.dart';
import 'package:hatspace/theme/hs_theme.dart';

ElevatedButtonThemeData primaryButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
  alignment: Alignment.center,
  textStyle: MaterialStatePropertyAll(
      textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
  backgroundColor: MaterialStateProperty.resolveWith((states) {
    //=====DISABLED EVENT
    if (states.contains(MaterialState.disabled)) {
      return HSColor.neutral3;
    } else {
      return HSColor.primary;
    }
  }),
  foregroundColor: MaterialStateProperty.resolveWith((states) {
    //=====DISABLED EVENT
    if (states.contains(MaterialState.disabled)) {
      return HSColor.neutral5;
    } else {
      return HSColor.onPrimary;
    }
  }),
  padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(vertical: 17, horizontal: 32)),
  shape: MaterialStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
));

OutlinedButtonThemeData secondaryButtonTheme = OutlinedButtonThemeData(
  style: ButtonStyle(
    textStyle: MaterialStatePropertyAll(
        textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
    alignment: Alignment.center,
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(vertical: 17, horizontal: 32)),
    shape: MaterialStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
    foregroundColor: MaterialStateProperty.resolveWith((states) {
      //=====DISABLED EVENT
      if (states.contains(MaterialState.disabled)) {
        return HSColor.neutral5;
      } else {
        return HSColor.neutral9;
      }
    }),
    side: MaterialStateBorderSide.resolveWith(
      (states) {
        // Disabled EVENT
        if (states.contains(MaterialState.disabled)) {
          return const BorderSide(color: HSColor.neutral3);
        } else {
          return const BorderSide(color: HSColor.neutral4);
        }
      },
    ),
  ),
);

TextButtonThemeData textOnlyButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
  textStyle: MaterialStatePropertyAll(
      textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
  alignment: Alignment.center,
  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(vertical: 17, horizontal: 32)),
  shape: MaterialStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
  foregroundColor: MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.disabled)) {
      return HSColor.neutral3;
    }
    return HSColor.primary;
  }),
));

OutlinedButtonThemeData tertiaryButtonTheme = OutlinedButtonThemeData(
    style: ButtonStyle(
  alignment: Alignment.center,
  textStyle: MaterialStatePropertyAll(
      textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700)),
  backgroundColor: MaterialStateProperty.resolveWith((states) {
    //=====DISABLED EVENT
    if (states.contains(MaterialState.disabled)) {
      return HSColor.neutral3;
    } else {
      return HSColor.accent;
    }
  }),
  foregroundColor: MaterialStateProperty.resolveWith((states) {
    //=====DISABLED EVENT
    if (states.contains(MaterialState.disabled)) {
      return HSColor.neutral5;
    } else {
      return HSColor.onAccent;
    }
  }),
  padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
      EdgeInsets.symmetric(vertical: 17, horizontal: 32)),
  shape: MaterialStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
  side: MaterialStateBorderSide.resolveWith(
    (states) {
      // Disabled EVENT
      if (states.contains(MaterialState.disabled)) {
        return const BorderSide(color: HSColor.neutral3);
      } else {
        return const BorderSide(color: HSColor.accent);
      }
    },
  ),
));
