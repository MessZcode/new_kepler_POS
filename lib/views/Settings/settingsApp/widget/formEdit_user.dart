import 'package:flutter/material.dart';
import 'package:kepler_pos/views/Settings/settingsApp/viewModel/setting_user_viewmodel.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../../../../ViewModel/base_viewmodel.dart';

class FormEditUserView extends StatefulWidget {
  const FormEditUserView({super.key, required this.userId});
  final int userId;
  @override
  State<FormEditUserView> createState() => _FormEditUserViewState();
}

class _FormEditUserViewState extends State<FormEditUserView> {

  final GlobalKey<FormFieldState<String>> _firstNameKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _lastNameKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _userNameKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _passwordKey = GlobalKey<FormFieldState<String>>();
  int? userId;
  String firstName = "";
  String lastName = "";
  String username = "";
  String password = "";
  DateTime? lastlogin ;
  int? selectValue;

  @override
  Widget build(BuildContext context) {

    const List<int> list = <int>[1, 2];
    final theme = Theme.of(context).colorScheme;

    void _handleSelectValueChange(int? newValue) {
      setState(() {
        selectValue = newValue;
      });
    }

    return AlertDialog(
        title: const Text("Edit User"),
        content: SizedBox(
          width: 300,
          height: 400,
          child: FutureBuilder(
            future:
            context.read<SettingUserViewModel>().getUserByOne(userId: widget.userId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                userId = snapshot.data!.userId;
                selectValue = selectValue ?? snapshot.data!.permissionLv;
                lastlogin = snapshot.data!.lastlogin;
                return SingleChildScrollView(
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("First Name"),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: TextFormField(
                            key: _firstNameKey,
                            // controller: fname,
                            initialValue: snapshot.data!.fname,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        const Text("Last Name"),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: TextFormField(
                            key: _lastNameKey,
                            // controller: lname,
                            initialValue: snapshot.data!.lname,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        const Text("username"),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: TextFormField(
                            key: _userNameKey,
                            readOnly: true,
                            initialValue: snapshot.data!.email,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        const Text("password"),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: TextFormField(
                            key: _passwordKey,
                            initialValue: snapshot.data!.password,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        const Text("permission Lv"),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: DropdownButton<int>(
                            value: selectValue??snapshot.data!.permissionLv,

                            underline: Container(),
                            isDense: false,
                            padding: null,
                            enableFeedback: true,
                            elevation: 20,
                            items: list.map((value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text(
                                  value.toString(),
                                ),
                              );
                            }).toList(),
                            onChanged: _handleSelectValueChange,
                            isExpanded: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: LoadingIndicator(
                    indicatorType: Indicator.lineSpinFadeLoader,
                    colors: [theme.onPrimary],
                  ),
                ),
              );
            },
          ),
        ),
      actions: [
        ElevatedButton(
          onPressed: () async {

            if (_firstNameKey.currentState!.validate()) {
              firstName = _firstNameKey
                  .currentState!.value
                  .toString();
            }


            if (_lastNameKey.currentState!.validate()) {
              lastName = _lastNameKey.currentState!.value
                  .toString();
            }
            if (_userNameKey.currentState!.validate()) {
              username = _userNameKey.currentState!.value
                  .toString();
            }
            if (_passwordKey.currentState!.validate()) {
              password = _passwordKey.currentState!.value
                  .toString();
            }

            UserModels newValue = UserModels(userId: userId!, fname: firstName, lname: lastName, lastlogin: lastlogin!, email: username, password: password, permissionLv: selectValue!);
            await context.read<SettingUserViewModel>().saveEditUser(newUserModel: newValue);
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.onSurface,
          ),
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
