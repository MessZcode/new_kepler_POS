import 'package:flutter/material.dart';
import 'package:kepler_pos/ViewModel/base_viewmodel.dart';
import 'package:provider/provider.dart';

class UserSettingView extends StatefulWidget {
  const UserSettingView({super.key});

  @override
  State<UserSettingView> createState() => _UserSettingViewState();
}

class _UserSettingViewState extends State<UserSettingView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.topLeft,
          child: TextButton.icon(
            style: const ButtonStyle(
              padding: MaterialStatePropertyAll(
                EdgeInsets.all(15),
              ),
              backgroundColor: MaterialStatePropertyAll(Colors.black12),
            ),
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text("Create"),
          ),
        ),
        FutureBuilder(
          future: context.read<BaseViewModel>().getUserAll(),
          builder: (context, snapshot) {

            if(snapshot.hasData){
              return Expanded(
                child: DataTable(
                  columnSpacing: 90,
                  showBottomBorder: true,
                  columns: const [
                    DataColumn(
                      label: Expanded(
                        child: Text("First Name"),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text("Last Name"),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text("Last Login"),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text("Username"),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text("Edit"),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text("Delete"),
                      ),
                    ),
                  ],
                  rows: [
                    // DataRow(cells: )
                  ],
                ),
              );
            }
            // if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("warning");
            // }
          },
        ),
      ],
    );
  }
}
