import 'package:flutter/material.dart';
import 'package:todo_assignment/utils/common/common_const.dart';
import 'package:todo_assignment/utils/common/widgets/custom_text.dart';

void showSnackBar(
    BuildContext context, String text, Color bgColor, Color textColor) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: bgColor,
      content: CustomText(
        title: text,
        fontSize: MediaQuery.of(context).size.width * numD035,
        color: textColor,
      ),
    ),
  );
}
