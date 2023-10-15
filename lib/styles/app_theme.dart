import 'package:flutter/material.dart';
import 'package:weatherapp/styles/styles.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(16),
      border: outlineBorder,
      errorBorder: outlineBorder,
      enabledBorder: outlineBorder,
      disabledBorder: outlineBorder,
      focusedBorder: outlineBorder,
      hintStyle: TStyle.T_14_400_15(Clr.CA098AE),
      labelStyle: TStyle.T_16_400_15(Clr.C363B64),
      helperStyle: TStyle.T_16_400_15(Clr.C363B64),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Clr.blue,
      secondary: Clr.white,
      onSurface: Clr.white,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: Clr.white,
        textStyle: TStyle.T_14_400_15(),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        visualDensity: VisualDensity.compact,
      ),
    ),
    iconTheme: const IconThemeData(color: Clr.white),
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(
        color: Clr.white,
      ),
      color: Clr.transparent,
      elevation: 0,
      titleTextStyle: TStyle.T_16_600_15(Clr.C363B64),
      centerTitle: true,
      foregroundColor: Clr.C363B64,
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      color: Clr.white,
    ),
    useMaterial3: true,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        backgroundColor: Clr.blueLight,
        foregroundColor: Clr.white,
        textStyle: TStyle.T_16_400_15(),
        visualDensity: VisualDensity.compact,
      ),
    ),
  );

  static final InputBorder outlineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(
      color: Clr.CD3D3D3,
      width: 1,
    ),
  );
}
