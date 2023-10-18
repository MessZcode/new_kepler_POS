import 'package:flutter/material.dart';
import 'package:kepler_pos/views/Settings/settingsApp/setting_category.dart';
import 'package:kepler_pos/views/Settings/settingsApp/setting_discount.dart';
import 'package:kepler_pos/views/Settings/settingsApp/setting_user.dart';

class SettingsAdmin extends StatefulWidget {
  const SettingsAdmin({super.key});

  @override
  State<SettingsAdmin> createState() => _SettingsAdminState();
}

class _SettingsAdminState extends State<SettingsAdmin> {
  String? selectValue;
  @override
  Widget build(BuildContext context) {
    const List<String> list = <String>[
      'setting users',
      'setting category',
      'setting discount',
      'setting menu'
    ];
    final theme = Theme.of(context).colorScheme;
    return Column(
      children: [
        _buildHeader(title: "Admin Settings"),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 10),
          decoration: ShapeDecoration(
            color: Theme.of(context).canvasColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: DropdownButton<String>(
            hint: Text(
              "select Setting",
              style: TextStyle(
                color: theme.onPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            value: selectValue,
            underline: Container(),
            isDense: false,
            padding: null,
            style: TextStyle(
              color: theme.onPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            enableFeedback: true,
            elevation: 20,
            items: list.map((value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectValue = newValue!;
              });
            },
            isExpanded: true,
          ),
        ),
        Expanded(
            child: _getSetting(value: selectValue),
        ),
      ],
    );
  }

  Widget _buildHeader({required String title}) {
    final theme = Theme.of(context).colorScheme;
    return Text(
      title,
      style: TextStyle(
        color: theme.primary,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _getSetting({required String? value}){
    final theme = Theme.of(context).colorScheme;
    if(value == "setting users") {
      return const UserSettingView();
    }
    if(value == "setting category") {
      return const SettingCategoryView();
    }
    if(value == "setting discount") {
      return const SettingDiscountView();
    }
    if(value == "setting menu") {
      return const Text("setting meny");
    }
    return Center(
      child: Text(
        "กรุณาเลือก setting ที่ต้องการ!",
        style: TextStyle(
          color: theme.onPrimary,
          fontSize: 30,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
