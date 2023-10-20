import 'package:flutter/material.dart';
import 'package:kepler_pos/ViewModel/home_viewModels.dart';
import 'package:provider/provider.dart';
import 'ViewModel/Routes/routes.dart';
import 'ViewModel/base_viewmodel.dart';
import 'ViewModel/bill_viewModel.dart';
import 'ViewModel/login_viewmodel.dart';
import 'ViewModel/membership_viewmodel.dart';
import 'ViewModel/navbar_viewmodel.dart';
import 'ViewModel/onBoarding_viewModel.dart';
import 'ViewModel/payment_viewModel.dart';
import 'ViewModel/report_viewmodel.dart';
import 'ViewModel/theme_viewmodel.dart';
import 'ViewModel/drawer_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BaseViewModel()),
        ChangeNotifierProvider(create: (context) => HomeViewModels()),
        ChangeNotifierProvider(create: (context) => NavbarViewModels()),
        ChangeNotifierProvider(create: (context) => Themeviewmodel()),
        ChangeNotifierProvider(create: (context) => OnboardingViewModel()),
        ChangeNotifierProvider(create: (context) => Loginviewmodel()),
        ChangeNotifierProvider(create: (context) => BillViewModels()),
        ChangeNotifierProvider(create: (context) => MembershipViewmodel()),
        ChangeNotifierProvider(create: (context) => ReportViewmodel()),
        ChangeNotifierProvider(
          create: (context) => PaymentViewModels(),
        ),
        ChangeNotifierProvider(
          create: (context) => DrawerViewModels(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      debugShowCheckedModeBanner: false,
      theme: Provider.of<Themeviewmodel>(context).settheme,
    );
  }
}
