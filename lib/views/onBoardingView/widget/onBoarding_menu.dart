import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
//
import '../../../utils/app_String.dart';
import '../../../utils/assets_Images.dart';
import 'button_menu.dart';

class Onboardingmenu extends StatefulWidget {
  const Onboardingmenu({super.key});

  @override
  State<Onboardingmenu> createState() => _OnboardingmenuState();
}

class _OnboardingmenuState extends State<Onboardingmenu> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final theme = Theme.of(context).colorScheme;
    return Positioned(
      right: 0,
      child: Container(
        width: screen.width * 0.45,
        height: screen.height,
        decoration: ShapeDecoration(
          color: theme.background,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            ),
          ),
          image: const DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage(
              ImageAssets.onboardingVectorImage,
            ),
            alignment: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(screen.height * 0.15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: screen.height * 0.1, child: Image.asset(ImageAssets.logo)),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: AppStrings.appTitle1,
                    style: TextStyle(
                      color: theme.onBackground,
                      fontSize: 54,
                      fontFamily: 'MuseoModerno',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: AppStrings.appTitle2,
                    style: TextStyle(
                      color: theme.secondary,
                      fontSize: 54,
                      fontFamily: 'MuseoModerno',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            AutoSizeText(
              AppStrings.onBoardingSubHead,
              style: TextStyle(
                color: theme.onPrimary,
                fontSize: 18,
                fontFamily: 'Noto Sans Thai',
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screen.height * 0.05),
              child: const Buttonmenu(),
            ),
          ]),
        ),
      ),
    );
  }
}
