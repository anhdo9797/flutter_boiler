import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const lightText = Colors.white;
  static const primary = Color(0xff09B83E);
  static const blue = Color.fromARGB(255, 9, 117, 184);
  static const success = Color.fromARGB(255, 79, 251, 0);
  static const error = Color(0xFFBA1A1A);

  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF2F7E79),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFF6EFF7C),
    onPrimaryContainer: Color(0xFF002105),
    secondary: Color(0xFF954A00),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFFFDCC6),
    onSecondaryContainer: Color(0xFF301400),
    tertiary: Color(0xFF39656B),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFBCEBF1),
    onTertiaryContainer: Color(0xFF001F23),
    error: error,
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFCFDF6),
    onBackground: Color(0xFF1A1C19),
    surface: Color.fromARGB(255, 255, 255, 255),
    onSurface: Color(0xFF1A1C19),
    surfaceVariant: Color(0xFFDEE5D9),
    onSurfaceVariant: Color(0xFF424940),
    outline: Color(0xFF72796F),
    onInverseSurface: Color(0xFFF0F1EB),
    inverseSurface: Color(0xFF2F312D),
    inversePrimary: Color(0xFF4DE262),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF006E21),
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFF2F7E79),
    onPrimary: Color(0xFF00390D),
    primaryContainer: Color(0xFF005316),
    onPrimaryContainer: Color(0xFF6EFF7C),
    secondary: Color(0xFFFFB785),
    onSecondary: Color(0xFF502500),
    secondaryContainer: Color(0xFF713700),
    onSecondaryContainer: Color(0xFFFFDCC6),
    tertiary: Color(0xFFA1CED5),
    onTertiary: Color(0xFF00363C),
    tertiaryContainer: Color(0xFF1F4D53),
    onTertiaryContainer: Color(0xFFBCEBF1),
    error: error,
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF1A1C19),
    onBackground: Color(0xFFE2E3DD),
    surface: Color(0xFF272925),
    onSurface: Color(0xFFE2E3DD),
    surfaceVariant: Color(0xFF424940),
    onSurfaceVariant: Color(0xFFC2C9BD),
    outline: Color(0xFF8C9388),
    onInverseSurface: Color(0xFF1A1C19),
    inverseSurface: Color(0xFFE2E3DD),
    inversePrimary: Color(0xFF006E21),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF4DE262),
    brightness: Brightness.dark,
  );
}
