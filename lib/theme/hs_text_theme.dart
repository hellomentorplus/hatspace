part of 'hs_theme.dart';

class FontStyleGuide {
  static const double fontSize38 = 38;
  static const double fontSize34 = 34;
  static const double fontSize30 = 30;
  static const double fontSize26 = 26;
  static const double fontSize24 = 24;
  static const double fontSize21 = 21;
  static const double fontSize20 = 20;
  static const double fontSize17 = 17;
  static const double fontSize16 = 16;
  static const double fontSize14 = 14;
  static const double fontSize13 = 13;
  static const double fontSize12 = 12;
  static const double fontSize10 = 10;
  static const double fontSize8 = 8;

  static const double letterSpacing0 = 0;
  static const double letterSpacing01 = 0.1;
  static const double letterSpacing015 = 0.15;
  static const double letterSpacing025 = 0.25;
  static const double letterSpacing04 = 0.4;
  static const double letterSpacing05 = 0.5;
  static const double letterSpacing125 = 1.25;
  static const double letterSpacing15 = 1.5;

  static const FontWeight fwRegular = FontWeight.w400;
  static const FontWeight fwSemibold = FontWeight.w600;
  static const FontWeight fwBold = FontWeight.w700;

  static const double height = 1.5;
}

const TextTheme textTheme = TextTheme(
  //TITLE
  titleLarge: TextStyle(
      fontSize: FontStyleGuide.fontSize34,
      fontWeight: FontStyleGuide.fwRegular,
      letterSpacing: FontStyleGuide.letterSpacing025,
      height: FontStyleGuide.height),

  //HEADLINE
  //headline1 => displayLarge
  // new design
  displayLarge: TextStyle(
      fontFamily: 'Manrope',
      fontSize: FontStyleGuide.fontSize24,
      fontWeight: FontStyleGuide.fwBold,
      letterSpacing: FontStyleGuide.letterSpacing0,
      height: FontStyleGuide.height),
  //headline2 => displayMedium
  displayMedium: TextStyle(
      fontSize: FontStyleGuide.fontSize26,
      fontWeight: FontStyleGuide.fwRegular,
      letterSpacing: FontStyleGuide.letterSpacing0,
      height: FontStyleGuide.height),

  //SUBTITLE
  //titleMedium ?? subtitle1
  titleMedium: TextStyle(
      fontSize: FontStyleGuide.fontSize17,
      fontWeight: FontStyleGuide.fwSemibold,
      letterSpacing: FontStyleGuide.letterSpacing015,
      height: FontStyleGuide.height),

  //BODY
  //bodyLarge ?? bodyText1
  bodyLarge: TextStyle(
      fontSize: FontStyleGuide.fontSize17,
      fontWeight: FontStyleGuide.fwRegular,
      letterSpacing: FontStyleGuide.letterSpacing05,
      height: FontStyleGuide.height),
  //bodyMedium ?? bodyText2
  // new design
  bodyMedium: TextStyle(
      fontFamily: 'Manrope',
      fontSize: FontStyleGuide.fontSize14,
      fontWeight: FontStyleGuide.fwRegular,
      letterSpacing: FontStyleGuide.letterSpacing04,
      height: FontStyleGuide.height),

  //BUTTON
  //labelLarge ?? button
  labelLarge: TextStyle(
      fontSize: FontStyleGuide.fontSize13,
      fontWeight: FontStyleGuide.fwRegular,
      letterSpacing: FontStyleGuide.letterSpacing04,
      height: FontStyleGuide.height),

  //CAPTION
  //bodySmall ?? caption
  bodySmall: TextStyle(
      fontSize: FontStyleGuide.fontSize12,
      fontWeight: FontStyleGuide.fwRegular,
      letterSpacing: FontStyleGuide.letterSpacing04,
      height: FontStyleGuide.height),

  //OVERLINE
  //labelSmall ?? overline
  labelSmall: TextStyle(
      fontSize: FontStyleGuide.fontSize10,
      fontWeight: FontStyleGuide.fwRegular,
      letterSpacing: FontStyleGuide.letterSpacing15,
      height: FontStyleGuide.height),
);

//SUBHEAD
const TextStyle subheadCustom = TextStyle(
    fontSize: FontStyleGuide.fontSize13,
    fontWeight: FontStyleGuide.fwSemibold,
    letterSpacing: FontStyleGuide.letterSpacing01,
    height: FontStyleGuide.height);

//OVERLINE2
const TextStyle overLine2Custom = TextStyle(
    fontSize: FontStyleGuide.fontSize8,
    fontWeight: FontStyleGuide.fwSemibold,
    letterSpacing: FontStyleGuide.letterSpacing15,
    height: FontStyleGuide.height);
