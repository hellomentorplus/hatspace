import 'package:flutter/material.dart';
import 'package:hatspace/gen/fonts.gen.dart';
import 'package:hatspace/theme/hs_button_theme.dart';

part 'hs_color.dart';
part 'hs_text_theme.dart';

ThemeData lightThemeData = ThemeData(
    textTheme: textTheme,
    colorScheme: colorScheme,
    elevatedButtonTheme: primaryButtonTheme,
    outlinedButtonTheme: secondaryButtonTheme,
    textButtonTheme: textOnlyButtonTheme,
    fontFamily: FontFamily.beVietnamPro);
