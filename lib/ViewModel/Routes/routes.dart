import 'package:flutter/material.dart';
import 'package:kepler_pos/views/Login/login_userpass.dart';
import 'package:kepler_pos/views/Login/select_login_screen.dart';
import 'package:kepler_pos/views/splashView/splash_screen_view.dart';

import '../../views/Login/login_pass.dart';
import '../../views/onBoardingView/onBoardingView.dart';
import '../../widgets/Navbar/navbar.dart';

class Routes {
  static const String mainRoute = "/";
  static const String onboardingRoute = "/onboarding";
  static const String selectLoginRoute = '/selectlogin';
  static const String loginRoute = "/login";
  static const String loginPassRoute = "/loginPass";
  static const String splashRoute = "/splash";

  static const String drawerRoute = "/drawer";
  static const String settingRoute = "/setting";
  static const String billRoute = "/bill";
  static const String homeRoute = "/home";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const mainView());
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const splashView());
      case Routes.onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.selectLoginRoute:
        return MaterialPageRoute(
          builder: (_) => const SelectLoginScreen(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (_) => const LoginUserpassScreen(),
        );
      case Routes.loginPassRoute:
        return MaterialPageRoute(
          builder: (_) => const LoginPass(),
        );
      default:
        return unDefineRoute();
    }
  }

  static Route<dynamic> unDefineRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Page NotFound"),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Page NotFound",
                style: TextStyle(fontSize: 30, color: Colors.grey),
              ),
              Text(
                "Page NotFound",
                style: TextStyle(fontSize: 30, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
