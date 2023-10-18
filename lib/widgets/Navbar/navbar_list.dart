import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kepler_pos/ViewModel/home_viewModels.dart';
import 'package:kepler_pos/widgets/Dialog/confirm_dialog.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/Routes/routes.dart';
import '../../ViewModel/base_viewmodel.dart';
import '../../ViewModel/navbar_viewmodel.dart';
import '../../utils/app_String.dart';
import '../../utils/assets_Images.dart';

class NavbarList extends StatefulWidget {
  const NavbarList({
    super.key,
  });

  @override
  State<NavbarList> createState() => _NavbarListState();
}

class _NavbarListState extends State<NavbarList> {
  @override
  Widget build(BuildContext context) {
    final ScrollController controller = ScrollController();
    final ScrollController controller2 = ScrollController();
    final theme = Theme.of(context).colorScheme;
    final pages = context.read<BaseViewModel>().pages;
    final navbarState = Provider.of<NavbarViewModels>(context);
    final billDetail = context.watch<HomeViewModels>().billDetail;
    final billOrder = context.watch<HomeViewModels>().billOrder;

    return Container(
      width: 120,
      height: double.infinity,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.only(right: 15),
      decoration: ShapeDecoration(
        color: theme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 10,
            offset: Offset(0, 10),
            spreadRadius: -5,
          ),
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 25,
            offset: Offset(0, 20),
            spreadRadius: -5,
          )
        ],
      ),
      child: SingleChildScrollView(
        controller: controller,
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListView.builder(
              primary: false,
              controller: controller2,
              shrinkWrap: true,
              // itemCount: 1,
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (event) {
                    if (index != 0) {
                      setState(() {
                        navbarState.onHoverPages(index);
                      });
                    }
                  },
                  onExit: (event) {
                    if (index != 0) {
                      setState(() {
                        navbarState.onHoverPages(index);
                      });
                    }
                  },
                  child: GestureDetector(
                    onTap: () {
                      if (index != 0) {
                        if (billDetail.isNotEmpty) {
                          _showDialog();
                        } else {
                          if (billOrder.orderId != 0) {
                            _showDialog();
                          } else {
                            setState(() {
                              Provider.of<NavbarViewModels>(context, listen: false).updateSelectPage(index);
                            });
                          }
                        }
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      padding: const EdgeInsets.only(
                        top: 16,
                        bottom: 16,
                        left: 25,
                        right: 24,
                      ),
                      decoration: ShapeDecoration(
                        color: navbarState.showPageSelect == index
                            ? theme.onBackground
                            : navbarState.hoverPages == index
                                ? theme.primaryContainer
                                : theme.background,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "${ImageAssets.navbarPath}/${pages[index].icon}",
                            width: 24,
                            height: 24,
                            color: navbarState.showPageSelect == index ? theme.background : theme.onPrimary,
                            // color: Color(0xFF7A8C96),
                          ),
                          SizedBox(
                            height: 25,
                            // width: double.infinity,
                            child: Text(
                              pages[index].pageTitle,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: navbarState.showPageSelect == index ? theme.background : theme.onPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            IconButton(
                onPressed: () {
                  navbarState.updateSelectPage(6);
                },
                icon: Icon(Icons.recent_actors_outlined)),
            PopupMenuButton<int>(
              offset: const Offset(80, -100),
              onSelected: (value) async {
                if (billDetail.isNotEmpty) {
                  _showDialog();
                } else {
                  if (billOrder.orderId != 0) {
                    _showDialog();
                  } else {
                    if (value == 0) {
                      _confirmSignOut_EndOfDay();
                    }
                    if (value == 1) {
                      _confirmEndOfDay();
                    }
                    if (value == 2) {
                      await context.read<BaseViewModel>().logout().then(
                            (value) => Navigator.pushReplacementNamed(context, Routes.onboardingRoute),
                          );
                    }
                  }
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem<int>(
                  value: 0,
                  child: PopUpMenuTile(
                    isActive: true,
                    icon: Icons.access_time,
                    title: AppStrings.endofdayAndlogout,
                  ),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: PopUpMenuTile(
                    isActive: true,
                    icon: Icons.access_time,
                    title: AppStrings.endofday,
                  ),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: PopUpMenuTile(
                    icon: Icons.logout,
                    title: AppStrings.menuBack,
                  ),
                ),
              ],
              child: GestureDetector(
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  padding: const EdgeInsets.only(
                    top: 16,
                    bottom: 16,
                    left: 34,
                    right: 24,
                  ),
                  decoration: ShapeDecoration(
                    color: theme.background,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.logout,
                        color: theme.error,
                        size: 35.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _confirmSignOut_EndOfDay() {
    final theme = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (context) {
        return Confirm_Dialog(
          text1: "Are you sure you want to",
          text2: "sign out and end of day?",
          onTap_yes: () => null,
          onTap_cancels: () => {Navigator.pop(context)},
          color_buttonyes: theme.onBackground,
          image: "assets/images/dialogImages/confirm.png",
          colorText1: theme.primary,
          colorText2: theme.primary,
        );
      },
    );
  }

  _confirmEndOfDay() {
    final theme = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (context) {
        return Confirm_Dialog(
          text1: "Are you sure you want to",
          text2: "end of day?",
          onTap_yes: () => null,
          onTap_cancels: () => {Navigator.pop(context)},
          color_buttonyes: theme.onBackground,
          image: "assets/images/dialogImages/confirm.png",
          colorText1: theme.primary,
          colorText2: theme.primary,
        );
      },
    );
  }

  _showDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        final theme = Theme.of(context).colorScheme;
        return AlertDialog(
          title: Text('Warning', style: TextStyle(color: theme.secondary)),
          content: SizedBox(
            width: 200,
            height: 150,
            child: Center(
              child: Text(
                "คุณต้อง ทำรายการบิลนี้ให้เสร็จก่อน",
                style: TextStyle(
                  color: theme.primary,
                  fontSize: 32.0,
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(theme.onBackground)),
              child: SizedBox(
                width: 300,
                child: Center(
                    child: Text(
                  "OK",
                  style: TextStyle(color: theme.background),
                )),
              ),
            ),
          ],
        );
      },
    );
  }
}

class PopUpMenuTile extends StatelessWidget {
  const PopUpMenuTile({required this.icon, required this.title, this.isActive = false});
  final IconData icon;
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: isActive ? Theme.of(context).secondaryHeaderColor : Theme.of(context).primaryColor),
        const SizedBox(
          width: 8,
        ),
        Text(
          title,
        ),
      ],
    );
  }
}
