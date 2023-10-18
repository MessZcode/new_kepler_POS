import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/Routes/routes.dart';
import '../../ViewModel/base_viewmodel.dart';
import '../../ViewModel/login_viewmodel.dart';
import '../../widgets/Keyboard/keyboard.dart';

class LoginUserpassScreen extends StatefulWidget {
  const LoginUserpassScreen({super.key});

  @override
  State<LoginUserpassScreen> createState() => _LoginUserpassScreenState();
}

class _LoginUserpassScreenState extends State<LoginUserpassScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final baseviwModel = Provider.of<BaseViewModel>(context);
    final loginviewmodel = Provider.of<Loginviewmodel>(context);
    final theme = Theme.of(context).colorScheme;

    final backButton = ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, Routes.selectLoginRoute);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: theme.onPrimary, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.arrow_back, color: theme.onPrimary),
          AutoSizeText(
            'Back',
            style: TextStyle(fontSize: 25, color: theme.onPrimary),
            maxFontSize: 25,
          ),
        ],
      ),
    );

    final loginTitle = AutoSizeText(
      'Login',
      style: TextStyle(
        color: theme.primary,
        fontSize: 36,
        fontWeight: FontWeight.w700,
      ),
      maxFontSize: 38,
    );

    final usernameField = Container(
      width: screenWidth * 0.4,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.background,
        border: Border.all(color: theme.surface),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            'Username',
            maxFontSize: 15,
            style: TextStyle(color: theme.primary),
          ),
          TextFormField(
            onTap: () {
              loginviewmodel.onTap_Textfeild(1);
            },
            showCursor: true,
            readOnly: true,
            focusNode: loginviewmodel.focusNodeUser,
            controller: loginviewmodel.username,
            decoration: InputDecoration(
              hintText: "Enter username",
              hintStyle: TextStyle(color: theme.onSurface),
              border: InputBorder.none,
              prefixIcon: Icon(Icons.person_outline, color: theme.onPrimary),
            ),
          ),
        ],
      ),
    );

    final passwordField = Container(
      width: screenWidth * 0.4,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.background,
        border: Border.all(color: theme.surface),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Password', style: TextStyle(color: theme.primary)),
          TextFormField(
            onTap: () {
              loginviewmodel.onTap_Textfeild(2);
            },
            showCursor: true,
            readOnly: true,
            obscureText: true,
            controller: loginviewmodel.password,
            focusNode: loginviewmodel.focusNodePass,
            decoration: InputDecoration(
              hintText: "Enter password",
              hintStyle: TextStyle(color: theme.onSurface),
              border: InputBorder.none,
              prefixIcon: Icon(Icons.lock_outline, color: theme.onPrimary),
            ),
          ),
        ],
      ),
    );

    final loginButton = InkWell(
      onTap: () {
        baseviwModel.checkLogin(loginviewmodel.username.text, loginviewmodel.password.text).then((status) {
          if (status) {
            loginviewmodel.onTap_login();
            setState(() {
              Navigator.pushReplacementNamed(context, Routes.mainRoute);
            });
          } else {
            if (loginviewmodel.username.text.isEmpty || loginviewmodel.password.text.isEmpty) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: theme.background,
                  content: Text('please enter username or password', style: TextStyle(color: theme.primary)),
                ),
              );
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                    backgroundColor: theme.background,
                    content: Text('please try enter username or password', style: TextStyle(color: theme.primary))),
              );
            }
          }
        });
      },
      child: Container(
        width: screenWidth * 0.4,
        height: screenHeight * 0.1,
        decoration: ShapeDecoration(
          color: theme.onBackground,
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
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Login',
            style: TextStyle(
              color: theme.background,
              fontSize: 36,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => Scaffold(
          body: GestureDetector(
            onTap: () {
              loginviewmodel.onTap_Textfeild(0);
            },
            child: Container(
              width: screenWidth,
              height: screenHeight,
              color: theme.onError,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.all(screenHeight * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: screenHeight * 0.03),
                          child: SizedBox(height: screenHeight * 0.06, width: screenWidth * 0.1, child: backButton),
                        ),
                        Expanded(
                          child: Container(
                            width: screenWidth,
                            decoration: ShapeDecoration(
                              color: theme.background,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(screenHeight * 0.03),
                                  child: loginTitle,
                                ),
                                usernameField,
                                Padding(
                                  padding: EdgeInsets.all(screenHeight * 0.02),
                                  child: passwordField,
                                ),
                                loginButton,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (loginviewmodel.textfeildnumber != 0)
                    Positioned(
                      bottom: 0,
                      child: Container(
                        color: theme.surface,
                        width: constraints.maxWidth,
                        height: constraints.maxHeight * 0.45,
                        child: Padding(
                          padding: EdgeInsets.all(constraints.maxHeight * 0.01),
                          child: Keyboard(
                            value: (String value) {
                              if (value == 'enter') {
                                baseviwModel
                                    .checkLogin(loginviewmodel.username.text, loginviewmodel.password.text)
                                    .then((status) {
                                  if (status) {
                                    loginviewmodel.onTap_login();
                                    setState(() {
                                      Navigator.pushReplacementNamed(context, Routes.mainRoute);
                                    });
                                  } else {
                                    if (loginviewmodel.username.text.isEmpty || loginviewmodel.password.text.isEmpty) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          backgroundColor: theme.background,
                                          content: Text('please enter username or password',
                                              style: TextStyle(color: theme.primary)),
                                        ),
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                            backgroundColor: theme.background,
                                            content: Text('please try enter username or password',
                                                style: TextStyle(color: theme.primary))),
                                      );
                                    }
                                  }
                                });
                              } else {
                                loginviewmodel.onTap_Keyboard(value);
                              }
                            },
                            Bgcolorkeynumber: theme.onPrimaryContainer,
                            Textcolorkeynumber: theme.background,
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
