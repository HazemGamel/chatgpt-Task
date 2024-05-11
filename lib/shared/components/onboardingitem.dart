import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../model/OnBoarding/on_boarding.dart';
import '../../screen/OnBoarding/on_boarding_screen.dart';
import '../style/color.dart';
import 'listoftext.dart';

class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem({super.key, required this.onBoardingModel});

  final OnBoardingModel onBoardingModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment:
      CrossAxisAlignment.center, children: [
        SvgPicture.asset(
          onBoardingModel.image,
          width: 24,
          fit: BoxFit.fitHeight,
          height: 24.h,
          placeholderBuilder: (_) => Shimmer.fromColors(
            baseColor: Colors.grey[850]!,
            highlightColor: Colors.grey[800]!,
            child: Container(
              height: 300.h,
              color: AppMainColors.greyColor,
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          onBoardingModel.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 30.h),
        ListOfText(onBoardingModel: onBoardingModel.body),
        SizedBox(height: 10.h),
        ListOfText(onBoardingModel: onBoardingModel.label),
        SizedBox(height: 10.h),
        ListOfText(onBoardingModel: onBoardingModel.text),
      ]),
    );
  }
}