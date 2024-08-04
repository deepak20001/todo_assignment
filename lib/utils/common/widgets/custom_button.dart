import 'package:flutter/material.dart';
import 'package:todo_assignment/utils/common/common_color.dart';
import 'package:todo_assignment/utils/common/common_const.dart';
import 'package:todo_assignment/utils/common/widgets/custom_text.dart';

/// ::::: Common Button :::::
class CustomButton extends StatelessWidget {
  final Function() onTap;
  final String buttonText;
  final double? radius;
  final Color? buttonColor;
  final FontWeight? fontWeight;
  final Color? borderColor;
  final double? buttonPaddingVertical;
  final Color? buttonTextColor;
  final double? buttonPaddingHorizontal;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.radius,
    this.fontWeight,
    this.borderColor,
    this.buttonColor,
    this.buttonTextColor,
    this.buttonPaddingHorizontal,
    this.buttonPaddingVertical,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              radius ?? size.width * numD01,
            ),
            side: BorderSide(
              color: borderColor ?? CommonColor.blackColor,
            ),
          ),
          backgroundColor: buttonColor ?? CommonColor.blackColor,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(
            vertical: buttonPaddingVertical ?? size.width * numD045,
            horizontal: buttonPaddingHorizontal ?? 0,
          ),
        ),
        child: CustomText(
          title: buttonText,
          fontSize: size.width * numD037,
          color: buttonTextColor ?? Colors.white,
          fontWeight: fontWeight ?? FontWeight.w500,
        ),
      ),
    );
  }
}
