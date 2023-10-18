import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//
import '../../ViewModel/membership_viewmodel.dart';
import '../../views/Home/addmember_dialog.dart';
import '../../ViewModel/home_viewModels.dart';

class MemberShipView extends StatefulWidget {
  const MemberShipView({
    super.key,
  });

  @override
  State<MemberShipView> createState() => _MemberShipViewState();
}

class _MemberShipViewState extends State<MemberShipView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final customer = context.watch<MembershipViewmodel>().customer;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return const AddmemberDialog();
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: theme.primaryContainer,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              children: [
                Image(
                  image: const AssetImage("assets/id.png"),
                  color: theme.onBackground,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    customer.customerId != 0 ? "K. ${customer.fname}" : "MemberShip",
                    style: TextStyle(
                      color: theme.onBackground,
                      fontSize: 20,
                      fontFamily: 'Noto Sans Thai',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )),
                if (customer.customerId != 0)
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: theme.onBackground,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      onPressed: () {
                        context.read<MembershipViewmodel>().clearCustomer();
                        context.read<HomeViewModels>().incrementBillDetail();
                      },
                      icon: Icon(
                        Icons.close,
                        color: theme.background,
                        size: 15,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
