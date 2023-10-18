import 'package:flutter/material.dart';

import '../utils/assets_Images.dart';

class OnboardingViewModel with ChangeNotifier {
  final List<String> _listImage = [
    ImageAssets.onboardListImage1,
    ImageAssets.onboardListImage2,
    ImageAssets.onboardListImage3,
  ];
  List<String> get slideImage => _listImage;
}
