import 'package:flutter/material.dart';
import 'package:kepler_pos/views/Bill/BillPage.dart';
import 'package:kepler_pos/views/Home/HomePage.dart';
import 'package:kepler_pos/views/Payment/payment_screen.dart';
import 'package:kepler_pos/widgets/whitespace_view.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/navbar_viewmodel.dart';
import '../../views/Drawer/drawer_Page.dart';
import '../../views/Report/report_view.dart';
import '../../views/Settings/setting_pages.dart';
import 'navbar_list.dart';

class mainView extends StatefulWidget {
  const mainView({super.key});

  @override
  State<mainView> createState() => _mainViewState();
}

class _mainViewState extends State<mainView> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> page = [
      const WhiteSpaceView(),
      const HomeView(),
      const BillPage(),
      const DrawerPage(),
      const SettingPage(),
      const PaymentScreen(),
      const Report(),
    ];

    final select = context.watch<NavbarViewModels>().selectPages;
    final theme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.onError,
        body: Row(
          children: [
            const NavbarList(),
            Flexible(
              child: page[select],
            ),
          ],
        ),
      ),
    );
  }
}
