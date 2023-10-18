import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/home_viewModels.dart';
import '../../ViewModel/membership_viewmodel.dart';
import '../../ViewModel/navbar_viewmodel.dart';

class successButtonDialog extends StatelessWidget {
  const successButtonDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final screen = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      contentPadding: EdgeInsets.all(screen.width * 0.01),
      actionsPadding: EdgeInsets.only(bottom: screen.height * 0.05),
      content: SizedBox(
        height: screen.height * 0.45,
        width: screen.width * 0.4,
        child: Column(children: [
          SizedBox(height: screen.height * 0.3, child: Image.asset('assets/Image_success.png')),
          Text(
            'Payment success!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: theme.onBackground,
              fontSize: 48,
              fontWeight: FontWeight.w700,
            ),
          ),
        ]),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                context.read<HomeViewModels>().clearAllinHome();
                context.read<MembershipViewmodel>().clearCustomer();
                Navigator.pop(context);
                context.read<NavbarViewModels>().updateSelectPage(1);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
                    )
                  ],
                ),
                child: Text(
                  'Back to Home',
                  style: TextStyle(
                    color: theme.background,
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
