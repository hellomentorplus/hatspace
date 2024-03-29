part of 'hs_theme.dart';

class HSColor {
  static const Color primary = Color(0xFF32A854); //  new design color
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryVariant = Color(0xFFCCF0D2);
  static const Color onPrimaryVariant = Color(0xFF282828);

  static const Color secondary = Color(0xFFFA612B);
  static const Color onSecondary = Color(0xFFF5F8F0);
  static const Color secondaryVariant = Color(0xFFFDA282);
  static const Color onSecondaryVariant = Color(0xFF282828);

  static const Color background = Color(0xFFFFFFFF); // new design color
  static const Color onBackground = Color(0xFF202020); // new design color
  static const Color backgroundVariant = Color(0xFFFDA282);

  static const Color surface = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF282828);

  static const Color accent = Color(0xffEBFAEF);
  static const Color onAccent = Color(0xFF32A854);

  static const Color statusError = Color(0xFFFF3B30);
  static const Color statusWarning = Color(0xFFFFCC00);
  static const Color statusSuccess = Color(0xFF34C759);
  static const Color statusInformational = Color(0xFF007AFF);

  static const Color requiredField = Color(0xFFFF3333); // new design color
  static const Color neutral10 = Color(0xFFF3F3F3);
  static const Color neutral8 = Color(0xFF202020); // new design color
  static const Color neutral7 = Color(0xFF383838); // new design color
  static const Color neutral6 = Color(0xff595959); // new desgin color

  //New design color
  static const Color neutral9 = Color(0xFF141414);

  static const Color neutral5 = Color(0xFF8C8C8C);
  static const Color neutral4 = Color(0xFFC7C7CC);
  static const Color neutral3 = Color(0xFFD9D9D9); // new design color
  static const Color neutral2 = Color(0xFFF3F3F3); // new design color
  static const Color neutral1 = Color(0xFFFFFFFF); // new design color

  static const Color green06 = Color(0xFF32A854); // new design color
  static const Color green05 = Color(0xff3ACD64); // new desgin color
  static const Color green01 = Color(0xFFEBFAEF); // new design color

  static const Color black = Color(0xFF000000);

  static const Color red05 = Color(0xFFFF3333); // new design color
  static const Color red06 = Color(0xFFD02D2D); // new design color

  static const Color orange05 = Color(0xFFFDA33A); // new design color

  static const Color blue05 = Color(0xFF2C6ECB); // new design color
  static const Color blue01 = Color(0xFFEDF4FF); // new design color
}

const ColorScheme colorScheme = ColorScheme(
  surfaceTint: Colors.transparent,
  brightness: Brightness.light,
  primary: HSColor.primary,
  onPrimary: HSColor.onPrimary,
  secondary: HSColor.secondary,
  onSecondary: HSColor.onSecondary,
  error: HSColor.statusError,
  onError: HSColor.neutral1,
  background: HSColor.background,
  onBackground: HSColor.onBackground,
  surface: HSColor.surface,
  onSurface: HSColor.onSurface,
);
