import 'package:flutter/material.dart';
import 'package:kepler_pos/ViewModel/home_viewModels.dart';
import 'package:provider/provider.dart';
//
import '../../ViewModel/membership_viewmodel.dart';
import '../../models/main_model.dart';
import '../../widgets/Dialog/confirm_dialog.dart';
import '../../widgets/Keyboard/keyboardnumber.dart';

class AddmemberDialog extends StatefulWidget {
  const AddmemberDialog({super.key});

  @override
  State<AddmemberDialog> createState() => _AddmemberDialogState();
}

class _AddmemberDialogState extends State<AddmemberDialog> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context);
    final phoneStringController = context.watch<MembershipViewmodel>().phoneStringController;
    final theme = Theme.of(context).colorScheme;

    Future<void> _onTapSubmitAddCustomer({required TextEditingController phoneStringController}) async {
      await context
          .read<MembershipViewmodel>()
          .checkCustomerByPhone(phoneString: phoneStringController.text)
          .then((customer) {
        if (customer != null) {
          Navigator.pop(context);
          setState(() {
            _showConfirmDialog(newCustomer: customer);
          });
        }
      });
    }

    return AlertDialog(
      contentPadding: const EdgeInsets.only(top: 24, right: 24, left: 24),
      actionsPadding: const EdgeInsets.only(bottom: 24, right: 24, left: 24),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Add member',
            style: TextStyle(
              fontSize: 32,
              color: theme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close, color: theme.onPrimary),
          ),
        ],
      ),
      content: Container(
        width: screen.size.width * 0.3,
        height: screen.size.height * 0.9,
        // padding: const EdgeInsets.all(24),
        decoration: ShapeDecoration(
          color: theme.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Column(
          children: [
            Expanded(
                child: Column(
              children: [
                Container(
                  // padding: const EdgeInsets.all(8),
                  decoration: ShapeDecoration(
                    color: theme.background,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: theme.onBackground),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
                        child: Row(
                          children: [
                            Text(
                              'Enter Phone number',
                              style: TextStyle(
                                color: theme.onBackground,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12, left: 12),
                        child: TextField(
                          showCursor: true,
                          readOnly: true,
                          autofocus: true,
                          keyboardType: TextInputType.phone,
                          controller: phoneStringController,
                          style: TextStyle(
                            color: theme.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '000-000-0000',
                            hintStyle: TextStyle(
                              color: theme.onPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: screen.size.height * 0.04),
                    child: SizedBox(
                      child: Keyboardnumber(
                        keyString: (String value) => context.read<MembershipViewmodel>().getDataToKeyboard(value),
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  context.read<MembershipViewmodel>().clearPhoneStringController();
                },
                child: Container(
                  // margin: const EdgeInsets.only(right: 20),
                  height: screen.size.height * 0.07,
                  decoration: ShapeDecoration(
                    color: theme.background,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: theme.onPrimary),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: theme.primary,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: screen.size.width * 0.01,
            ),
            Expanded(
              child: InkWell(
                onTap: () async {
                  await _onTapSubmitAddCustomer(phoneStringController: phoneStringController);
                },
                child: Container(
                  height: screen.size.height * 0.07,
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
                  child: Center(
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: theme.background,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showConfirmDialog({required CustomerModels newCustomer}) {
    final theme = Theme.of(context).colorScheme;
    final homeViewModel = Provider.of<HomeViewModels>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Confirm_Dialog(
            text1: 'K. ${newCustomer.fname}',
            text2: 'confirm customer membership?',
            onTap_yes: () {
              context.read<MembershipViewmodel>().saveCustomer(newCustomer: newCustomer);
              homeViewModel.setMemberShipViewModel(context.read<MembershipViewmodel>());
              homeViewModel.incrementBillDetail();
              Navigator.pop(context);
              context.read<MembershipViewmodel>().clearPhoneStringController();
            },
            onTap_cancels: () {
              Navigator.pop(context);
              context.read<MembershipViewmodel>().clearPhoneStringController();
              homeViewModel.incrementBillDetail();
            },
            color_buttonyes: theme.onBackground,
            image: 'assets/Image.png',
            colorText1: theme.onBackground,
            colorText2: theme.primary);
      },
    );
  }
}
