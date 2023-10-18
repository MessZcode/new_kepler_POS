import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kepler_pos/ViewModel/home_viewModels.dart';
import 'package:kepler_pos/widgets/Dialog/success_dialog.dart';
import 'package:provider/provider.dart';
//
import '../../ViewModel/membership_viewmodel.dart';
import '../Dialog/confirm_dialog.dart';
import 'billDetail_list.dart';
import 'memberShip.dart';
import 'total_payment.dart';

class ShowDetail extends StatelessWidget {
  const ShowDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final billDetails = context.watch<HomeViewModels>().billDetail;
    return Container(
      width: MediaQuery.of(context).size.width * 0.26,
      decoration: BoxDecoration(
        color: theme.background,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          Expanded(
            flex: MediaQuery.of(context).size.height >= 800 ? 2 : 1,
            child: Column(
              children: [
                //Header
                detailHeader(context: context),
                //MemberDetail && MemberShip
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: MemberShipView(),
                ),
                //Bill Detail
                const Bill_Detail_List(),
              ],
            ),
          ),
          // Amount
          if (billDetails.isNotEmpty)
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.35,
              child: const TotalPayment(),
            ),
        ],
      ),
    );
  }

  Widget detailHeader({required BuildContext context}) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: AutoSizeText(
              'Bill Detail',
              maxFontSize: 32,
              minFontSize: 1,
              maxLines: 1,
              overflowReplacement: ClipRRect(),
              style: TextStyle(
                fontSize: 32,
                color: theme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Confirm_Dialog(
                      text1: 'Are you sure you want to',
                      text2: 'cancel bill?',
                      onTap_yes: () {
                        context.read<MembershipViewmodel>().clearCustomer();
                        context.read<HomeViewModels>().clearBill();
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (context) => const Success_Dialog(text: 'Cancel bill success!'),
                        );
                      },
                      onTap_cancels: () {
                        Navigator.pop(context);
                      },
                      color_buttonyes: theme.error,
                      image: 'assets/images/dialogImages/Cancel.png',
                      colorText1: theme.primary,
                      colorText2: theme.primary);
                },
              );
            },
            child: Container(
              width: 52,
              height: 52,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme.error,
                  width: 1,
                ),
              ),
              child: Image.asset(
                "assets/trash.png",
                fit: BoxFit.cover,
                color: theme.error,
              ),
            ),
          )
        ],
      ),
    );
  }
}
