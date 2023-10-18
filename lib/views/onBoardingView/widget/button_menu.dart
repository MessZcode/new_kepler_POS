import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../ViewModel/Routes/routes.dart';
import '../../../utils/app_String.dart';
import '../../../utils/assets_Images.dart';

//
class Buttonmenu extends StatefulWidget {
  const Buttonmenu({super.key});

  @override
  State<Buttonmenu> createState() => _ButtonmenuState();
}

class _ButtonmenuState extends State<Buttonmenu> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final screen = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SizedBox(
            height: screen.height * 0.23,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.selectLoginRoute,
                );
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: screen.height * 0.065),
                  // padding: EdgeInsets.all(screen.height * 0.06),
                  backgroundColor: theme.onBackground,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28))),
              child: Column(
                children: [
                  Expanded(
                    child: SizedBox(
                        height: screen.height * 0.07,
                        child: Image.asset(
                          ImageAssets.login,
                          color: theme.background,
                        )),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      AppStrings.login,
                      maxFontSize: 30,
                      minFontSize: 1,
                      style: TextStyle(fontSize: 28, color: theme.background),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: screen.width * 0.01,
        ),
        Expanded(
          child: SizedBox(
            height: screen.height * 0.23,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: theme.background,
                    // padding: EdgeInsets.all(screen.height * 0.06),
                    padding: EdgeInsets.symmetric(vertical: screen.height * 0.065),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                        side: BorderSide(color: theme.onBackground, width: 2))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                          child: Image.asset(
                        ImageAssets.endofday,
                        color: theme.onBackground,
                      )),
                    ),
                    Expanded(
                      child: AutoSizeText(
                        AppStrings.endofday,
                        maxFontSize: 30,
                        minFontSize: 1,
                        style: TextStyle(color: theme.onBackground, fontSize: 28),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
