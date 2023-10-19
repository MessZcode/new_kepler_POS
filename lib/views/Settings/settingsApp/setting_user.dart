import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    // final theme = Theme.of(context).colorScheme;

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
            if (snapshot.hasData) {
              return Expanded(
                child: SingleChildScrollView(
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
                    rows: snapshot.hasData
                        ? List.generate(snapshot.data!.length, (index) {
                            return DataRow(cells: <DataCell>[
                              DataCell(
                                Text(snapshot.data![index].fname),
                              ),
                              DataCell(
                                Text(snapshot.data![index].lname),
                              ),
                              DataCell(
                                Text(DateFormat('dd MMM yyyy').format(snapshot.data![index].lastlogin).toString()),
                              ),
                              DataCell(
                                Text(snapshot.data![index].email),
                              ),
                              DataCell(
                                InkWell(
                                  onTap: () {},
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.amber,
                                      size: 24.0, // ตั้งค่าขนาดไอคอน
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                InkWell(
                                  onTap: () {},
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 24.0, // ตั้งค่าขนาดไอคอน
                                    ),
                                  ),
                                ),
                              ),
                            ]);
                          })
                        : [],
                  ),
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
