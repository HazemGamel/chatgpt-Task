
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gpttask/shared/style/color.dart';

class ListOfOptions extends StatelessWidget {
  const ListOfOptions({
    super.key,
    required this.imageIcon,
    required this.text,
    this.iconColor,
    this.textColor,
    required this.function,
  });
  final String imageIcon;
  final String text;
  final Color? iconColor;
  final Color? textColor;
  final void Function()? function;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function!();
      },
      child: Container(
        width: 335.w,
        height: 52.h,
        alignment: Alignment.center,
        margin: const EdgeInsetsDirectional.symmetric(horizontal: 16),
        child: Row(
          children: [
            ImageIcon(
              color: iconColor ?? AppMainColors.whiteColor,
              AssetImage(imageIcon),
            ),
            SizedBox(width: 16.w),
            Text(
              text,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: textColor ?? AppMainColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}