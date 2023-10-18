import 'dart:async';
//
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kepler_pos/ViewModel/home_viewModels.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/Routes/routes.dart';
import '../../ViewModel/base_viewmodel.dart';
import '../../ViewModel/bill_viewModel.dart';
import '../../ViewModel/drawer_viewmodel.dart';
import '../../utils/app_String.dart';
import '../../utils/assets_Images.dart';

class splashView extends StatefulWidget {
  const splashView({super.key});

  @override
  State<splashView> createState() => _splashViewState();
}

class _splashViewState extends State<splashView> {
  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  _startDelay() async {
    await context.read<BaseViewModel>().start().then((Status value) {
      if (!value.loadData) {
        _showErrorDialog();
      } else {
        final homeViewModel = Provider.of<HomeViewModels>(context, listen: false);
        homeViewModel.setBaseViewModel(context.read<BaseViewModel>());
        final billViewModel = Provider.of<BillViewModels>(context, listen: false);
        billViewModel.setBaseViewModel(context.read<BaseViewModel>());
        Provider.of<DrawerViewModels>(context, listen: false).updateCurrentCash();
        Timer(const Duration(seconds: 1), _goNext);
      }
    });
  }

  _goNext() {
    if (context.read<BaseViewModel>().profile.userId != 0) {
      Navigator.pushReplacementNamed(context, Routes.mainRoute);
    } else {
      Navigator.pushReplacementNamed(context, Routes.onboardingRoute);
    }
  }

  _showErrorDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      useSafeArea: true,
      builder: (context) {
        return AlertDialog(
          title: const Text("เชื่อมต่อข้อมูลไม่สำเร็จกรุณาลองอีกครั้ง"),
          // content: const Text(DialogString.eFetchdata),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _startDelay();
              },
              child: const Text(AppStrings.menuRetry),
            ),
            TextButton(
              onPressed: () async {
                await SystemNavigator.pop();
              },
              child: const Text(AppStrings.menuClose),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    final theme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: theme.onBackground,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLogo(),
                        const SizedBox(width: 32),
                        _buildAppTitle(),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildLoadingIndicator(),
                    const SizedBox(height: 32),
                    _buildCallbackString(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 200,
      height: 191.21,
      decoration: ShapeDecoration(
        color: const Color(0xFFFEFEFE),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      child: Image.asset(
        ImageAssets.logo,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildAppTitle() {
    return const Column(
      children: [
        Text(
          "${AppStrings.appTitle1}\n ${AppStrings.appTitle2}",
          style: TextStyle(
            color: Color(0xFFFEFEFE),
            fontSize: 64,
            fontFamily: 'MuseoModerno',
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return const SizedBox(
      width: 40,
      height: 40,
      child: LoadingIndicator(
        indicatorType: Indicator.lineSpinFadeLoader,
        colors: [Colors.white],
      ),
    );
  }

  Widget _buildCallbackString() {
    final statusString = context.watch<BaseViewModel>().statusString;
    return Text("Loading ... $statusString");
  }
}
