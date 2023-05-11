import 'package:flutter/material.dart';
import 'package:hatspace/gen/fonts.gen.dart';

part 'hs_color.dart';
part 'hs_text_theme.dart';

ThemeData lightThemeData = ThemeData(
    scaffoldBackgroundColor: colorScheme.background,
    textTheme: textTheme,
    colorScheme: colorScheme,
    fontFamily: FontFamily.beVietnamPro,
    dividerTheme: DividerThemeData(
      color: HSColor.neutral3,
      thickness: 1.0,
    ));
