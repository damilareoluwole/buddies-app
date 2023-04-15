import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static var containerPadding = const EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  );
  //static var fontName = 'Josefin';
  static var fontName = 'Montserrat';
  static var bodyFontSize = 12.0;
  static var bodyFontWeight = FontWeight.w500;

  static var whiteColor = HexColor('#FFFFFF');
  static var veryLightRedColor = HexColor('#FF6161');
  static var blackColor = HexColor('#000000');
  static var shadowColor = HexColor('#583DC7');
  static var lightRedColor = HexColor('#DF4460');
  static var darkLemonColor = HexColor('#BA9700');
  static var purpleColor = HexColor('#8100AC');
  static var deepDarkRedColor = HexColor('#940826');
  static var deepDarkGreyColor = HexColor('##336666');
  static var darkRedColor = HexColor('#D60C1C');
  static var greenColor = HexColor('#3B971F');
  static var redColor = HexColor('#DC0000');
  static var darkGreyColor = HexColor('#333333');
  static var greyColor = HexColor('#666666');
  static var textColor = HexColor('#1A1A1A');
  static var pinkColor = HexColor('#FFF4F5');
  static var textInputColor = HexColor('#FFB5B5');
  static var textInputHintColor = HexColor('#4D4D4D');
  static var bottomBarColor = HexColor('#FFE9E9');
  static var headerContainerColor = HexColor('#E6E6E6').withOpacity(0.5);
  static var pink2 = HexColor('#FFE9E9');
  static var pink3 = HexColor('#FFF4F5');
  static var grey = HexColor('#808080');
  static var grey2 = HexColor('#666666');
  static var linkBlueColor = HexColor('#6699FF');
  static var faintColor = HexColor('#FFB5B5');

  static TextStyle body = const TextStyle();
  static TextStyle callout = const TextStyle();
  static TextStyle calloutSmall = const TextStyle();
  static TextStyle caption1 = const TextStyle();
  static TextStyle caption2 = const TextStyle();
  static TextStyle caption2b = const TextStyle();
  static TextStyle headline = const TextStyle();
  static TextStyle subHeadline = const TextStyle();
  static TextStyle button = const TextStyle();
  static TextStyle button1 = const TextStyle();
  static TextStyle resetHeader = const TextStyle();
  static TextStyle authHeader = const TextStyle();
  static TextStyle hintText = const TextStyle();
  static TextStyle footnote = const TextStyle();
  static TextStyle footnote2 = const TextStyle();
  static TextStyle title2 = const TextStyle();
  static TextStyle title3 = const TextStyle();
  static TextStyle whoText = const TextStyle();
  static TextStyle settingsHeader = const TextStyle();

  static setTextTheme() {
    body = TextStyle(
      fontFamily: fontName,
      leadingDistribution: TextLeadingDistribution.even,
      height: 1.3,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 16.0,
      letterSpacing: -0.41,
      color: textColor,
    );

    callout = TextStyle(
      fontFamily: fontName,
      leadingDistribution: TextLeadingDistribution.even,
      height: 1.3,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      fontSize: 16.0,
      letterSpacing: -0.32,
      color: textColor,
    );

    calloutSmall = TextStyle(
      fontFamily: fontName,
      leadingDistribution: TextLeadingDistribution.even,
      height: 1.3,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
      letterSpacing: -0.32,
      color: textColor,
    );

    caption1 = TextStyle(
      fontFamily: fontName,
      leadingDistribution: TextLeadingDistribution.even,
      height: 1.3,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 11.0,
      color: textColor,
    );

    caption2 = TextStyle(
      fontFamily: fontName,
      leadingDistribution: TextLeadingDistribution.even,
      height: 1.3,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      fontSize: 10.0,
      letterSpacing: -0.06,
      color: textColor,
    );

    caption2b = TextStyle(
      fontFamily: fontName,
      leadingDistribution: TextLeadingDistribution.even,
      height: 1.3,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 11.0,
      letterSpacing: -0.06,
      color: textColor,
    );

    resetHeader = TextStyle(
      fontFamily: fontName,
      leadingDistribution: TextLeadingDistribution.even,
      height: 1.3,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      fontSize: 20.0,
      letterSpacing: -0.06,
      color: darkGreyColor,
    );

    settingsHeader = TextStyle(
      fontFamily: fontName,
      leadingDistribution: TextLeadingDistribution.even,
      height: 1.3,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 20.0,
      letterSpacing: -0.06,
      color: blackColor,
    );

    authHeader = TextStyle(
      fontFamily: fontName,
      leadingDistribution: TextLeadingDistribution.even,
      height: 1.3,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      fontSize: 28.0,
      letterSpacing: -0.06,
      color: textColor,
    );

    headline = TextStyle(
      fontFamily: fontName,
      leadingDistribution: TextLeadingDistribution.even,
      height: 1.3,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      fontSize: 15.0,
      letterSpacing: -0.41,
      color: textColor,
    );

    button = TextStyle(
      fontFamily: fontName,
      leadingDistribution: TextLeadingDistribution.even,
      height: 1.3,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 15.0,
      letterSpacing: -0.06,
      color: whiteColor,
    );

    button1 = TextStyle(
      fontFamily: fontName,
      leadingDistribution: TextLeadingDistribution.even,
      height: 1.3,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 12.0,
      letterSpacing: -0.06,
      color: whiteColor,
    );

    subHeadline = TextStyle(
      fontFamily: fontName,
      leadingDistribution: TextLeadingDistribution.even,
      height: 1.3,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
      letterSpacing: -0.24,
      color: blackColor,
    );

    hintText = TextStyle(
      fontFamily: fontName,
      leadingDistribution: TextLeadingDistribution.even,
      height: 1.3,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 13.0,
      letterSpacing: -0.24,
      color: textInputHintColor,
    );

    whoText = TextStyle(
      fontFamily: fontName,
      leadingDistribution: TextLeadingDistribution.even,
      height: 1.3,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      fontSize: 13.0,
      letterSpacing: -0.24,
      color: whiteColor,
    );

    footnote = TextStyle(
      fontFamily: fontName,
      leadingDistribution: TextLeadingDistribution.even,
      height: 1.3,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 12.0,
      letterSpacing: -0.08,
      color: blackColor,
    );

    footnote2 = TextStyle(
      fontFamily: fontName,
      leadingDistribution: TextLeadingDistribution.even,
      height: 1.3,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
      letterSpacing: -0.08,
      color: textInputHintColor,
    );

    title2 = TextStyle(
      fontFamily: fontName,
      leadingDistribution: TextLeadingDistribution.even,
      height: 1.3,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      fontSize: 21.0,
      color: textColor,
    );

    title3 = TextStyle(
      fontFamily: fontName,
      leadingDistribution: TextLeadingDistribution.even,
      height: 1.3,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 19.0,
      color: textColor,
    );
  }

  static var bottomSheetStyle = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
  );
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}
