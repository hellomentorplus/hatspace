part of 'hs_theme.dart';

class HSColor {
  static const Color primary = Color(0xFF3ACD64);
  static const Color onPrimary = Color(0xFFF5F8F0);
  static const Color primaryVariant = Color(0xFFCCF0D2);
  static const Color onPrimaryVariant = Color(0xFF282828);

  static const Color secondary = Color(0xFFFA612B);
  static const Color onSecondary = Color(0xFFF5F8F0);
  static const Color secondaryVariant = Color(0xFFFDA282);
  static const Color onSecondaryVariant = Color(0xFF282828);

  static const Color background = Color(0xFFF8F8F8);
  static const Color onBackground = Color(0xFF282828);
  static const Color backgroundVariant = Color(0xFFFDA282);

  static const Color surface = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF282828);

  static const Color accent = Color(0xFF007C50);
  static const Color onAccent = Color(0xFFF5F8F0);

  static const Color statusError = Color(0xFFFF3B30);
  static const Color statusWarning = Color(0xFFFFCC00);
  static const Color statusSuccess = Color(0xFF34C759);
  static const Color statusInformational = Color(0xFF007AFF);

  static const Color neutral6 = Color(0xFF8E8E93);
  static const Color neutral5 = Color(0xFFAEAEB2);
  static const Color neutral4 = Color(0xFFC7C7CC);
  static const Color neutral3 = Color(0xFFD1D1D6);
  static const Color neutral2 = Color(0xFFE5E5EA);
  static const Color neutral1 = Color(0xFFFAFAFA);
}

const ColorScheme colorScheme = ColorScheme(
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
    onSurface: HSColor.onSurface);
