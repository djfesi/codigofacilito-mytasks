import 'dart:ui';

import 'package:MyTask/theme/size_app.dart';
import 'package:flutter/cupertino.dart';

class AppTextStyle {
  TextStyle h134;
  TextStyle h132;
  TextStyle h226;
  TextStyle h220;
  TextStyle h214;
  TextStyle paragraph16;
  TextStyle paragraph12;

  AppTextStyle(
      {required this.h134,
      required this.h132,
      required this.h226,
      required this.h220,
      required this.h214,
      required this.paragraph16,
      required this.paragraph12});

  factory AppTextStyle.textStyles() {
    return AppTextStyle(
      h134: _styleRalewayBold.copyWith(fontSize: sizeTextH134),
      h132: _styleRalewayBold.copyWith(fontSize: sizeTextH132),
      h226: _styleRalewaySemiBold.copyWith(fontSize: sizeTextH226),
      h220: _styleRalewaySemiBold.copyWith(fontSize: sizeTextH220),
      h214: _styleRalewaySemiBold.copyWith(fontSize: sizeTextH214),
      paragraph16: _stylePuppins.copyWith(fontSize: sizeTextParagraph16),
      paragraph12: _stylePuppins.copyWith(fontSize: sizeTextParagraph12),
    );
  }

  static TextStyle get _styleRalewayBold =>
      TextStyle(fontFamily: "Raleway-Regular", fontWeight: FontWeight.w700);

  static TextStyle get _styleRalewaySemiBold =>
      TextStyle(fontFamily: "Raleway-Regular", fontWeight: FontWeight.w600);

  static TextStyle get _stylePuppins =>
      TextStyle(fontFamily: "Poppins-Regular");
}
