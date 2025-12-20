import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomTextView extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final Color? decorationColor;


  const CustomTextView({
    super.key,
    required this.text,
    this.textStyle,
    this.textAlign = TextAlign.left,
    this.overflow,
    this.maxLines,
    this.color = Colors.black,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.normal,
    this.fontFamily = 'Poppins',
    this.fontStyle  = FontStyle.normal,
    this.decoration  = TextDecoration.none,
    this.decorationColor  = AppColors.blackFont,

  });


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        decoration: decoration,
        decorationColor: decorationColor,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
      ).merge(textStyle),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
