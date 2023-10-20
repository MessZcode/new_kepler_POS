import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kepler_pos/views/Settings/settingsApp/viewModel/setting_user_viewmodel.dart';
import 'package:kepler_pos/views/Settings/settingsApp/widget/formCreate_user.dart';
import 'package:kepler_pos/views/Settings/settingsApp/widget/formEdit_user.dart';
import 'package:loading_indicator/loading_indicator.dart';
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
            onPressed: () {
              showDialog(context: context, builder: (context) => const FormCreateUserView(),);
            },
            icon: const Icon(Icons.add),
            label: const Text("Create"),
          ),
        ),
        FutureBuilder(
          future: context.read<SettingUserViewModel>().getUserAll(),
          builder: (context, snapshot) {

            if (snapshot.hasData) {
              final userAll = context.watch<SettingUserViewModel>().userAll;
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
                        ? List.generate(userAll.length, (index) {
                            return DataRow(cells: <DataCell>[
                              DataCell(
                                Text(userAll[index].fname),
                              ),
                              DataCell(
                                Text(userAll[index].lname),
                              ),
                              DataCell(
                                Text(userAll[index].lastlogin!=null ?DateFormat('dd MMM yyyy')
                                    .format(userAll[index].lastlogin!)
                                    .toString():"" ),
                              ),
                              DataCell(
                                Text(userAll[index].email),
                              ),
                              DataCell(
                                InkWell(
                                  onTap: () {
                                    // print(userAll[index].userId);
                                    showDialog(context: context, builder: (context) => FormEditUserView(userId: userAll[index].userId),);
                                    // Navigator.of(context).pop();
                                  },
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
                                  onTap: () {
                                    context.read<SettingUserViewModel>().deleteUserById(userId: snapshot.data![index].userId);
                                  },
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
            if (snapshot.hasError) {
              return const Text("something went wrong");
            }
            return SizedBox(
              width: 20,
              height: 20,
              child: LoadingIndicator(
                indicatorType: Indicator.lineSpinFadeLoader,
                colors: [theme.onPrimary],
              ),
            );
            // }
          },
        ),
      ],
    );
  }
}

