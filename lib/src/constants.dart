import 'package:flutter/material.dart';

// App Theme
final appTheme = ThemeData(
  useMaterial3: true,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.light,
  fontFamily: 'Qanelas',
  primaryColor: kPrimaryColor,
);

// Color Schema
const Color kPrimaryColor = Color(0xff2171D2);
const Color kSecondaryColor = Color(0xffFFA800);
const Color kBackgroundCardColor = Color(0xffF9F9F9);
const Color kShadowColor = Color(0xff8194A3);
const Color kErrorColor = Color(0xffEC273A);
const Color kGrayColor = Color(0xFF919191);
final chartColors = [
  const Color(0xff2171D2),
  const Color(0xFF33629B),
  const Color(0xFF71A4E4),
  const Color(0xffFFA800),
  const Color(0xFFFFC44E),
  const Color(0xFFFF9100),
  const Color(0xFFD458FA),
  kGrayColor,
];

// Constants values
const double kBorderRadius = 20.0;
const double kMarginHorizontal = 10.0;
double getStatusBar(BuildContext context) => MediaQuery.of(context).viewPadding.top;
