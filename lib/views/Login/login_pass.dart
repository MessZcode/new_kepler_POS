import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../ViewModel/Routes/routes.dart';
import '../../ViewModel/base_viewmodel.dart';
import '../../ViewModel/login_viewmodel.dart';
import '../../models/login_model.dart';
import '../../widgets/Keyboard/keyboard.dart';

class LoginPass extends StatefulWidget {
  const LoginPass({super.key});

  @override
  State<LoginPass> createState() => _LoginPassState();
}

class _LoginPassState extends State<LoginPass> {
  @override
  Widget build(BuildContext context) {
    final index = context.watch<Loginviewmodel>().indexuser;
    final userlastlogin = context.watch<BaseViewModel>().userslastlogin;
    final loginviewmodel = Provider.of<Loginviewmodel>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final baseviewmodel = context.read<BaseViewModel>();
    return SafeArea(
        child: LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        body: Stack(
          children: [
            GestureDetector(
              onTap: () {
                loginviewmodel.onTap_Textfeild(0);
              },
              child: Container(
                width: screenWidth,
                height: screenHeight,
                decoration: const ShapeDecoration(
                  color: Color(0xFFF4F6F7),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFF252525),
                    ),
                  ),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenHeight * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: screenHeight * 0.03),
                            child: SizedBox(
                              height: screenHeight * 0.06,
                              width: screenWidth * 0.1,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/selectlogin');
                                    loginviewmodel.onTap_login();
                                    loginviewmodel.selectLogin(0);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          side: const BorderSide(color: Colors.black26, width: 1))),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(Icons.arrow_back, color: Colors.black38),
                                      AutoSizeText(
                                        'Back',
                                        style: TextStyle(fontSize: 25, color: Colors.black38),
                                        maxFontSize: 25,
                                      )
                                    ],
                                  )),
                            ),
                          ),
                          Expanded(
                              child: Container(
                            width: screenWidth,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFFEFEFE),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: Column(children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                                child: const AutoSizeText(
                                  'Login',
                                  style: TextStyle(
                                    color: Color(0xFF252525),
                                    fontSize: 36,
                                    fontFamily: 'Noto Sans Thai',
                                    fontWeight: FontWeight.w700,
                                  ),
                                  maxFontSize: 38,
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: constraints.maxWidth * 0.4,
                                    height: screenHeight * 0.07,
                                    child: TextFormField(
                                      onTap: null,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.person_outline),
                                          hintText: userlastlogin[index].fname,
                                          hintStyle: TextStyle(color: Colors.black45),
                                          filled: true,
                                          fillColor: Colors.black12,
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                                    child: Container(
                                      width: constraints.maxWidth * 0.4,
                                      height: screenHeight * 0.1,
                                      padding: EdgeInsets.all(screenHeight * 0.01),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.black12),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const AutoSizeText('Password'),
                                          Expanded(
                                            child: TextFormField(
                                              onTap: () {
                                                loginviewmodel.onTap_Textfeild(2);
                                              },
                                              showCursor: true,
                                              readOnly: true,
                                              obscureText: true,
                                              controller: loginviewmodel.password,
                                              decoration: const InputDecoration(
                                                  hintText: "Enter password",
                                                  hintStyle: TextStyle(color: Colors.black38),
                                                  border: InputBorder.none,
                                                  prefixIcon: Icon(Icons.lock_outline)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      baseviewmodel
                                          .checkLogin(userlastlogin[index].email, loginviewmodel.password.text)
                                          .then((value) {
                                        if (value == true) {
                                          loginviewmodel.onTap_login();
                                          Navigator.pushNamed(context, '/');
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return const AlertDialog(
                                                content: Text('try again'),
                                              );
                                            },
                                          );
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: screenWidth * 0.4,
                                      height: screenHeight * 0.1,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFF1CAF82),
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
                                      child: const Center(
                                        child: AutoSizeText(
                                          'Login',
                                          style: TextStyle(
                                            color: Color(0xFFFEFEFE),
                                            fontSize: 36,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // ),
                                ],
                              ),
                            ]),
                          )),
                        ],
                      ),
                    ),
                    if (loginviewmodel.textfeildnumber != 0)
                      Positioned(
                        bottom: 0,
                        child: Container(
                          color: Color.fromRGBO(188, 193, 212, 1),
                          width: constraints.maxWidth,
                          height: constraints.maxHeight * 0.45,
                          child: Padding(
                            padding: EdgeInsets.all(constraints.maxHeight * 0.01),
                            child: Keyboard(
                              value: (String value) {
                                if (value == 'enter') {
                                  baseviewmodel
                                      .checkLogin(userlastlogin[index].email, loginviewmodel.password.text)
                                      .then((value) {
                                    if (value == true) {
                                      loginviewmodel.onTap_login();
                                      Navigator.pushNamed(context, '/');
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const AlertDialog(
                                            content: Text('try again'),
                                          );
                                        },
                                      );
                                    }
                                  });
                                } else {
                                  loginviewmodel.onTap_Keyboard(value);
                                }
                              },
                              Bgcolorkeynumber: Color.fromRGBO(87, 87, 118, 1),
                              Textcolorkeynumber: Colors.white,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
