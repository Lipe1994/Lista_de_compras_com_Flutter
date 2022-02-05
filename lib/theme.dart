import 'package:flutter/material.dart';

ThemeData get themeData => ThemeData(
      colorScheme: eoColorsToColorScheme,
      scaffoldBackgroundColor: whiteColor,
      unselectedWidgetColor: separatorsColor,
      splashColor: secondaryColor,
      highlightColor: primaryColor.withOpacity(0.5),
      appBarTheme: const AppBarTheme(
        elevation: 0,
      ),
      iconTheme: IconThemeData(color: paragraphyColor, size: 16),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        textStyle: textVerySmall,
        primary: paragraphyColor,
        alignment: Alignment.center,
      )),
      buttonTheme: ButtonThemeData(
        buttonColor: secondaryColor,
        height: 36,
        minWidth: double.infinity,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 42),
        textStyle: paragraphy.copyWith(color: whiteColor),
        primary: secondaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      )),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 42),
          textStyle: paragraphy.copyWith(color: secondaryColor),
          side: BorderSide(color: secondaryColor, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      textTheme: TextTheme(
          subtitle1: paragraphy,
          subtitle2: headline1,
          headline1: headline1,
          headline2: headline2,
          bodyText1: paragraphy,
          bodyText2: textSmall,
          caption: textVerySmall,
          button: paragraphy.copyWith(color: whiteColor)),
    );

//Colors for light theme
Color get primaryColor => const Color(0XFF69F0AE);
Color get secondaryColor => const Color(0XFF2BBD7E);
Color get separatorsColor => const Color(0XFFBDBDBD);
Color get bigTitleColor => const Color(0XFF212121);
Color get titleColor => const Color(0XFF757575);
Color get paragraphyColor => const Color(0XFF555555).withOpacity(0.8);
Color get textSmallColor => const Color(0XFF757575);
Color get textVerySmallColor => const Color(0XFFBDBDBD);
Color get lightGrayColor => const Color(0XFFF0F0F0);
Color get errorColor => const Color(0XFFFF5252);

Color get whiteColor => const Color(0XFFFFFFFF);

ColorScheme get eoColorsToColorScheme => ColorScheme(
    primary: primaryColor,
    onPrimary: whiteColor,
    surface: primaryColor,
    onSurface: secondaryColor,
    secondary: secondaryColor,
    background: Colors.black,
    error: Colors.black,
    onSecondary: Colors.black,
    onBackground: Colors.black,
    onError: Colors.black,
    brightness: Brightness.light,
    primaryVariant: Colors.black,
    secondaryVariant: Colors.black);

//tipografia
TextStyle get headline1 => TextStyle(
      fontWeight: FontWeight.bold,
      color: bigTitleColor,
      fontSize: 32,
      height: 1.2,
      fontFamily: 'Roboto',
    );

TextStyle get headline2 => TextStyle(
      fontWeight: FontWeight.normal,
      color: titleColor,
      fontSize: 24,
      height: 1.2,
      fontFamily: 'Roboto',
    );

TextStyle get paragraphy => TextStyle(
    fontWeight: FontWeight.normal,
    color: paragraphyColor,
    fontSize: 16,
    height: 1.2,
    fontFamily: 'Roboto');

TextStyle get textSmall => TextStyle(
      fontWeight: FontWeight.normal,
      color: textSmallColor,
      fontSize: 13,
      height: 1.2,
      fontFamily: 'Roboto',
    );
TextStyle get textVerySmall => TextStyle(
      fontWeight: FontWeight.normal,
      color: textVerySmallColor,
      fontSize: 12,
      height: 1.2,
      fontFamily: 'Roboto',
    );
