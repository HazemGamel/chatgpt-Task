import 'package:gpttask/shared/style/color.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.label,
    this.fontSize,
    this.textColor,
    this.fontWeight,
    this.maxLine,
  }) : super(key: key);

  final String label;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final int? maxLine;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      maxLines: maxLine,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: textColor ?? AppMainColors.whiteColor,
            fontSize: fontSize,
            fontWeight: fontWeight ?? FontWeight.w500,
          ),
    );
  }
}
