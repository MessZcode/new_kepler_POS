import 'package:flutter/material.dart';
import 'package:kepler_pos/views/Login/widget/loginsuggest.dart';

import '../../ViewModel/Routes/routes.dart';

//
class SelectLoginScreen extends StatelessWidget {
  const SelectLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return SafeArea(child: LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: theme.onError,
          body: SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Padding(
              padding: EdgeInsets.all(constraints.maxHeight * 0.03),
              child: Column(children: [
                Row(children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.onboardingRoute);
                    },
                    child: Container(
                      width: constraints.maxWidth * 0.1,
                      height: constraints.maxHeight * 0.08,
                      decoration: ShapeDecoration(
                        color: theme.background,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: theme.onPrimary),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Center(
                        child: Text.rich(TextSpan(children: [
                          WidgetSpan(
                              child: Icon(
                            Icons.arrow_back,
                            color: theme.onPrimary,
                          )),
                          TextSpan(
                              text: '  back',
                              style: TextStyle(
                                color: theme.onPrimary,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ))
                        ])),
                      ),
                    ),
                  )
                ]),
                SizedBox(
                  height: constraints.maxHeight * 0.02,
                ),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: theme.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Column(children: [
                    Text('Login',
                        style: TextStyle(
                          color: theme.primary,
                          fontSize: 38,
                          fontWeight: FontWeight.w700,
                        )),
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                    SizedBox(
                      width: constraints.maxWidth,
                      child: Center(
                        child: SizedBox(
                          height: constraints.maxHeight * 0.2,
                          child: const loginsuggest(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                    Text('Or login with',
                        style: TextStyle(
                          color: theme.onPrimary,
                          fontWeight: FontWeight.w500,
                        )),
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.loginRoute);
                      },
                      child: Container(
                        height: constraints.maxHeight * 0.07,
                        width: constraints.maxWidth * 0.15,
                        decoration: ShapeDecoration(
                          color: theme.background,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: theme.onBackground),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person_2_outlined, color: theme.onBackground),
                            Text(
                              ' Username/Password?',
                              style: TextStyle(
                                color: theme.onBackground,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ]),
                )),
              ]),
            ),
          ),
        );
      },
    ));
  }
}
