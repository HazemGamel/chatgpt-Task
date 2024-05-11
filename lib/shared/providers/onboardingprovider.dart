import 'package:flutter/cupertino.dart';

import '../../model/OnBoarding/on_boarding.dart';
import '../style/images.dart';

class OnBoardingProvider with ChangeNotifier{


  var pageController = PageController();
  List<OnBoardingModel> onBoarding = [
    OnBoardingModel(
      image: Assets.imagesFrame,
      title: 'Examples',
      body: '“Explain quantum computing in\n simple terms”',
      label: "“Got any creative ideas for a 10\n year old's birthday?”",
      text: '“How do I make an HTTP request\n in Javascript?”',
    ),
    OnBoardingModel(
      image: Assets.imagesVector1,
      title: 'Capabilities',
      body: 'Remembers what user said earlier\n in the conversation',
      label: 'Allows user to provide follow-up\n corrections',
      text: 'Trained to decline inappropriate\n requests',
    ),
    OnBoardingModel(
      image: Assets.imagesGroup,
      title: 'Limitations',
      body: 'May occasionally generate\n incorrect information',
      label:
      'May occasionally produce harmful\n instructions or biased content',
      text: 'Limited knowledge of world and\n events after 2021',
    ),
  ];
  bool isLast = false;

  void changes(index){
    if (index == onBoarding.length - 1) {
        isLast = true;
        notifyListeners();
    } else {
        isLast = false;
        notifyListeners();
    }
  }

}