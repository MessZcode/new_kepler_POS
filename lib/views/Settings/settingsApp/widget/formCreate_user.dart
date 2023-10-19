import 'package:flutter/material.dart';

class FormCreateUserView extends StatefulWidget {
  const FormCreateUserView({super.key});

  @override
  State<FormCreateUserView> createState() => _FormCreateUserViewState();
}

class _FormCreateUserViewState extends State<FormCreateUserView> {
  final GlobalKey<FormFieldState<String>> _firstNameKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _lastNameKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _userNameKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _passwordKey =
      GlobalKey<FormFieldState<String>>();
  int? userId;
  String firstName = "";
  String lastName = "";
  String username = "";
  String password = "";
  DateTime? lastlogin;
  int? selectPermission;

  @override
  Widget build(BuildContext context) {
    const List<int> list = <int>[1, 2];
    final theme = Theme.of(context).colorScheme;

    void _handleSelectValueChange(int? newValue) {
      setState(() {
        selectPermission = newValue;
      });
    }

    return AlertDialog(
      title: const Text("Create User"),
      content: SizedBox(
        width: 300,
        height: 400,
        child: SingleChildScrollView(
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
                    // initialValue: snapshot.data!.fname,
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
                    // initialValue: snapshot.data!.lname,
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
                    // readOnly: true,
                    // initialValue: snapshot.data!.email,
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
                    // initialValue: snapshot.data!.password,
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
                    // value: selectValue ?? snapshot.data!.permissionLv,
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
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (_firstNameKey.currentState!.validate()) {
              firstName = _firstNameKey.currentState!.value.toString();
            }

            if (_lastNameKey.currentState!.validate()) {
              lastName = _lastNameKey.currentState!.value.toString();
            }
            if (_userNameKey.currentState!.validate()) {
              username = _userNameKey.currentState!.value.toString();
            }

            if (_passwordKey.currentState!.validate()) {
              password = _passwordKey.currentState!.value.toString();
            }

            // UserModels newValue = UserModels(
            //     userId: userId!,
            //     fname: firstName,
            //     lname: lastName,
            //     lastlogin: lastlogin!,
            //     email: username,
            //     password: password,
            //     permissionLv: selectValue!);
            // await context
            //     .read<SettingUserViewModel>()
            //     .saveEditUser(newUserModel: newValue);
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
