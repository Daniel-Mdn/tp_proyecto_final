import 'dart:core';
import 'package:flutter/material.dart';

class AppMaterialTheme {
  static const Color primaryColor = Color(0xFF00677E);
  static const Color onPrimaryColor = Color(0xFFFFFFFF);
  static const Color primaryContainerColor = Color(0xFFB4EBFF);
  static const Color onPrimaryContainerColor = Color(0xFF001F28);
  static const Color inversePrimaryColor = Color(0xFF75D3F1);
  static const Color onPrimaryFixedColor = Color(0xFF001F28);
  static const Color onPrimaryFixedVariant = Color(0xFF384950);
  static const Color primaryFixedDimColor = Color(0xFF75D3F1);
  static const Color primaryFixedColor = Color(0xFFB4EBFF);
  static const Color secondaryColor = Color(0xFF4F6168);
  static const Color onSecondaryColor = Color(0xFFFFFFFF);
  static const Color secondaryContainerColor = Color(0xFFD2E6EE);
  static const Color onSecondaryContainerColor = Color(0xFF0B1E24);
  static const Color onSecondaryFixedVariantColor = Color(0xFF384950);
  static const Color onSecondaryFixedColor = Color(0xFF0B1E24);
  static const Color secondaryFixedColor = Color(0xFFD2E6EE);
  static const Color secondaryFixedDimColor = Color(0xFFB6CAD2);
  static const Color tertiaryColor = Color(0xFF5A5C79);
  static const Color tertiaryFixedColor = Color(0xFFE0E0FF);
  static const Color tertiaryFixedDimColor = Color(0xFFC3C4E5);
  static const Color onTertiaryColor = Color(0xFFFFFFFF);
  static const Color tertiaryContainerColor = Color(0xFFE0E0FF);
  static const Color onTertiaryFixedColor = Color(0xFF171932);
  static const Color onTertiaryContainerColor = Color(0xFF171932);
  static const Color onTertiaryFixedVariantColor = Color(0xFF424560);
  static const Color errorColor = Color(0xFFBA1A1A);
  static const Color onErrorColor = Color(0xFFFFFFFF);
  static const Color errorContainerColor = Color(0xFFFFDAD6);
  static const Color onErrorContainerColor = Color(0xFF410002);
  static const Color scrimColor = Color(0xFF000000);
  static const Color shadowColor = Color(0xFF000000);
  static const Color surfaceColor = Color(0xFFF5FAFD);
  static const Color onSurfaceColor = Color(0xFF191C1D);
  static const Color surfaceBrightColor = Color(0xFFF5FAFD);
  static const Color surfaceContainerColor = Color(0xFFF0F1F2);
  static const Color surfaceContainerHighColor = Color(0xFFE2E2E4);
  static const Color surfaceContainerHighestColor = Color(0xFFE2E2E4);
  static const Color surfaceContainerLowColor = Color(0xFFEFF4F7);
  static const Color surfaceContainerLowestColor = Color(0xFFFFFFFF);
  static const Color surfaceDimColor = Color(0xFFD6DBDD);
  static const Color surfaceTintColor = Color(0xFFD6DBDD);
  static const Color inverseSurfaceColor = Color(0xFF2E3132);
  static const Color onInverseSurfaceColor = Color(0xFFF0F1F2);
  static const Color onSurfaceVariantColor = Color(0xFF41484B);
  static const Color outlineColor = Color(0xFF71787B);
  static const Color outlineVariantColor = Color(0xFFC1C7CB);

  static const colorScheme = ColorScheme(
    primary: primaryColor,
    onPrimary: onPrimaryColor,
    primaryContainer: primaryContainerColor,
    onPrimaryContainer: onPrimaryContainerColor,
    secondary: secondaryColor,
    onSecondary: onSecondaryColor,
    secondaryContainer: secondaryContainerColor,
    onSecondaryContainer: onSecondaryContainerColor,
    tertiary: tertiaryColor,
    onTertiary: onTertiaryColor,
    tertiaryContainer: tertiaryContainerColor,
    onTertiaryContainer: onTertiaryContainerColor,
    error: errorColor,
    onError: onErrorColor,
    errorContainer: errorContainerColor,
    onErrorContainer: onErrorContainerColor,
    surface: surfaceColor,
    onSurface: onSurfaceColor,
    inversePrimary: inversePrimaryColor,
    inverseSurface: inverseSurfaceColor,
    onInverseSurface: onInverseSurfaceColor,
    onPrimaryFixed: onPrimaryFixedColor,
    onPrimaryFixedVariant: onPrimaryFixedVariant,
    onSecondaryFixed: onSecondaryFixedColor,
    onSecondaryFixedVariant: onSecondaryFixedVariantColor,
    onSurfaceVariant: onSurfaceVariantColor,
    onTertiaryFixed: onTertiaryFixedColor,
    onTertiaryFixedVariant: onTertiaryFixedVariantColor,
    outline: outlineColor,
    outlineVariant: outlineVariantColor,
    primaryFixedDim: primaryFixedDimColor,
    scrim: scrimColor,
    secondaryFixed: secondaryFixedColor,
    secondaryFixedDim: secondaryFixedDimColor,
    shadow: shadowColor,
    surfaceBright: surfaceBrightColor,
    primaryFixed: primaryFixedColor,
    surfaceContainer: surfaceContainerColor,
    surfaceContainerHigh: surfaceContainerHighColor,
    surfaceContainerHighest: surfaceContainerHighestColor,
    surfaceContainerLow: surfaceContainerLowColor,
    surfaceContainerLowest: surfaceContainerLowestColor,
    surfaceDim: surfaceDimColor,
    surfaceTint: surfaceTintColor,
    tertiaryFixed: tertiaryFixedColor,
    tertiaryFixedDim: tertiaryFixedDimColor,
    brightness: Brightness.light,
  );
}
