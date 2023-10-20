import 'package:flutter/material.dart';

class SettingCategoryView extends StatefulWidget {
  const SettingCategoryView({super.key});

  @override
  State<SettingCategoryView> createState() => _SettingCategoryViewState();
}

class _SettingCategoryViewState extends State<SettingCategoryView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
            },
            icon: const Icon(Icons.add),
            label: const Text("Create"),
          ),
        ),
        // FutureBuilder[Container]
      ],
    );
  }
}
