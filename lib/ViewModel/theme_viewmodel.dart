import 'package:flutter/material.dart';

import '../utils/colorManager.dart';

class Themeviewmodel extends ChangeNotifier {
  late ThemeData _settheme;
  late int idselect = 1;
  Themeviewmodel() {
    _settheme = customThemeGreen();
  }

  ThemeData get settheme => _settheme;

  void tapchangeTheme(int id) {
    if (id == 1) {
      idselect = 1;
      _settheme = customThemeGreen();
    } else if (id == 2) {
      idselect = 2;
      _settheme = customThemeDark();
    }

    notifyListeners();
  }

  ThemeData customThemeGreen() {
    return ThemeData(
      fontFamily: 'Noto Sans Thai',
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        background: ColorManager.base_light,
        onBackground: ColorManager.primary500,
        secondary: ColorManager.secondary500,
        primary: ColorManager.base_dark,
        onPrimary: ColorManager.dark400,
        error: ColorManager.danger500,
        primaryContainer: ColorManager.primary100,
        onSecondary: ColorManager.dark50,
        secondaryContainer: ColorManager.secondary100,
        onError: ColorManager.light50,
        surface: ColorManager.light300,
        onSurface: ColorManager.dark200,
        onPrimaryContainer: ColorManager.light800,
      ),
    );
  }

  ThemeData customThemeDark() {
    return ThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        background: ColorManager.dark900,
        onBackground: ColorManager.dark50,
        secondary: ColorManager.blue300,
        primary: ColorManager.warning300,
        onPrimary: ColorManager.base_light,
        error: ColorManager.blue200,
        primaryContainer: ColorManager.danger200,
        onSecondary: ColorManager.dark800,
        secondaryContainer: ColorManager.blue500,
        onError: ColorManager.base_dark,
        surface: ColorManager.light300,
        onSurface: ColorManager.dark400,
        onPrimaryContainer: ColorManager.light50,
      ),
    );
  }
}
