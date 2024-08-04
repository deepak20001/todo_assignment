import 'package:flutter/material.dart';

/// ::::: Common Text :::::
class CustomText extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final String? fontFamily;
  final Color color;
  final bool isHashTag;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final Color shadowColor;
  final double dx;
  final double dy;
  final double? letterSpacing;
  final int? maxLine;
  final double topSpacing;
  final double bottomSpacing;
  final double leftSpacing;
  final double rightSpacing;
  final double? height;

  const CustomText({
    super.key,
    required this.title,
    this.isHashTag = false,
    required this.fontSize,
    this.fontWeight = FontWeight.w400,
    this.color = Colors.black,
    this.textAlign,
    this.fontFamily,
    this.overflow,
    this.letterSpacing,
    this.decoration = TextDecoration.none,
    this.decorationColor,
    this.shadowColor = Colors.transparent,
    this.dx = 0,
    this.dy = 0,
    this.maxLine,
    this.topSpacing = 0,
    this.bottomSpacing = 0,
    this.leftSpacing = 0,
    this.rightSpacing = 0,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: topSpacing,
        bottom: bottomSpacing,
        left: leftSpacing,
        right: rightSpacing,
      ),
      child: Text(
        title,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLine,
        style: TextStyle(
          decorationColor: decorationColor,
          shadows: [Shadow(offset: Offset(dx, dy), color: shadowColor)],
          decoration: decoration,
          letterSpacing: letterSpacing,
          fontStyle: FontStyle.normal,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          height: height,
        ),
      ),
    );
  }
}
