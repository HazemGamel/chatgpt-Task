import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpttask/screen/OnBoarding/on_boarding_screen.dart';
import 'package:gpttask/shared/components/navigator.dart';
import 'package:gpttask/shared/style/images.dart';

import '../../shared/style/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3),(){
      navigateAndFinish(context, OnBoardingScreen());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppMainColors.secondColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: SvgPicture.asset(Assets.imagesSplash,width: 200,
                height: 200,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
