import 'package:flutter/material.dart';
import 'package:kepler_pos/views/onBoardingView/widget/imageSlideShow.dart';
import 'package:kepler_pos/views/onBoardingView/widget/onBoarding_menu.dart';
//
class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});
  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => const Stack(
          children: [
            PhotoSlideshow(),
            Onboardingmenu(),
          ],
        ),
      ),
    );
  }
}