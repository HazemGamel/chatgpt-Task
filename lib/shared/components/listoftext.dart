
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListOfText extends StatelessWidget {
  const ListOfText({
    super.key,
    required this.onBoardingModel,
  });

  final String onBoardingModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335.w,
      height: 65.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xff444550),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 37.5.w,
        vertical: 12.h,
      ),
      child: Text(
        onBoardingModel,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}