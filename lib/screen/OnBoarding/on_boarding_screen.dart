import 'package:gpttask/shared/providers/onboardingprovider.dart';
import 'package:gpttask/shared/style/images.dart';
import 'package:gpttask/screen/Dashboard/dashboard_screen.dart';
import 'package:gpttask/shared/components/navigator.dart';
import 'package:gpttask/shared/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/onboardingitem.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingprovider = Provider.of<OnBoardingProvider>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 10,
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
            Center(
              child: SvgPicture.asset(
                Assets.imagesLogo,
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
            ),
            SizedBox(height: 10),
            Text(
              'Welcome to\n ChatGPT',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 10),
            Text(
              'Ask anything, get your answer',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 30),
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  onboardingprovider.changes(index);
                },
                controller:onboardingprovider.pageController,
                itemBuilder: (context, index) => OnBoardingItem(
                  onBoardingModel:onboardingprovider.onBoarding[index],
                ),
                itemCount: onboardingprovider.onBoarding.length,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmoothPageIndicator(
                  controller:onboardingprovider.pageController,
                  count: onboardingprovider.onBoarding.length,
                  effect: WormEffect(
                    dotWidth: 28.w,
                    dotHeight: 2.h,
                    dotColor: AppMainColors.whiteColor.withOpacity(0.2),
                    activeDotColor: AppMainColors.primaryColor,
                    spacing: 12,
                    radius: 12,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                if (onboardingprovider.isLast) {
                  navigateAndFinish(context, const DashboardScreen());
                } else {
                  onboardingprovider.pageController.nextPage(
                    duration: const Duration(
                      milliseconds: 780,
                    ),
                    curve: Curves.ease,
                  );
                }
              },
              child: Container(
                margin: const EdgeInsetsDirectional.only(
                  start: 20,
                  end: 20,
                  bottom: 20,
                ),
                height: 48.h,
                width: 335.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppMainColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child:onboardingprovider.isLast
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Let's Chat",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(width: 12),
                          SvgPicture.asset(
                            Assets.imagesArrowForward,
                            width: 10.w,
                            height: 12.h,
                          ),
                        ],
                      )
                    : Text(
                        'Next',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}


