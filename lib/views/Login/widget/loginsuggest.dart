import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kepler_pos/ViewModel/base_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../ViewModel/login_viewmodel.dart';

class loginsuggest extends StatefulWidget {
  const loginsuggest({super.key});

  @override
  State<loginsuggest> createState() => _loginsuggestState();
}

class _loginsuggestState extends State<loginsuggest> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BaseViewModel>().getUsers();
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final screen = MediaQuery.of(context).size;
    final userlastlogin = context.watch<BaseViewModel>().userslastlogin;
    final loginviewmodel = Provider.of<Loginviewmodel>(context, listen: false);
    return ListView.builder(
      itemCount: userlastlogin.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Row(
          children: [
            InkWell(
              onTap: () async {
                loginviewmodel.selectLogin(1);
                context.read<Loginviewmodel>().selectIndexUser(index);
                Navigator.pushNamed(
                  context,
                  '/loginPass',
                );
              },
              child: Container(
                width: screen.width * 0.23,
                height: screen.height * 0.16,
                margin: EdgeInsets.symmetric(horizontal: screen.width * 0.01),
                // padding: const EdgeInsets.only(right: 24),
                decoration: ShapeDecoration(
                  color: theme.onError,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Container(
                    width: screen.width * 0.095,
                    height: screen.height * 0.16,
                    decoration: ShapeDecoration(
                      color: theme.onBackground,
                      shape: OvalBorder(
                        side: BorderSide(width: 1, color: theme.background),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x0F000000),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                          spreadRadius: -1,
                        ),
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 6,
                          offset: Offset(0, 4),
                          spreadRadius: -1,
                        )
                      ],
                    ),
                    child: Center(
                        child: Text(
                      userlastlogin[index].fname.substring(0, 1),
                      style: TextStyle(
                        color: theme.background,
                        fontWeight: FontWeight.w700,
                        fontSize: 48,
                      ),
                    )),
                  ),
                  SizedBox(
                    width: screen.width * 0.01,
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userlastlogin[index].fname,
                          style: TextStyle(
                            color: theme.primary,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          )),
                      SizedBox(
                        height: screen.height * 0.01,
                      ),
                      Text(
                        userlastlogin[index].email,
                        style: TextStyle(
                          fontSize: 18,
                          color: theme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ))
                ]),
              ),
            ),
          ],
        );
      },
    );
  }
}
