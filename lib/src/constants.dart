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
final chartIncomesColor = [
  kPrimaryColor,
  kSecondaryColor,
  kGrayColor,
];
final chartExpenseColors = [
  kPrimaryColor,
  kSecondaryColor,
  const Color(0xFF009688),
  const Color(0xffff9800),
  const Color(0xFF8bc34a),
  const Color(0xFFf44336),
  const Color(0xFFad1457),
  kGrayColor,
];

// Constants values
const double kBorderRadius = 20.0;
const double kMarginHorizontal = 10.0;
double getStatusBar(BuildContext context) => MediaQuery.of(context).viewPadding.top;
