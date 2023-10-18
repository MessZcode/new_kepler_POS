import 'package:flutter/material.dart';
//
import '../../models/setting_model.dart';

import 'settinglist.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({
    super.key,
  });

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final item = List<String>.generate(10, (index) => 'Item $index');

  List<MenuSettingList> listlvmenu = [];
  bool _selected = false;

  dynamic itemnow = {};
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    addlistview();
    itemnow = listlvmenu.elementAt(0);
  }

  void addlistview() {
    listlvmenu.add(MenuSettingList(1, 'assets/user-circle.png', "Profile"));
    listlvmenu
        .add(MenuSettingList(2, 'assets/moon.png', "Display & accessibility"));
    listlvmenu.add(MenuSettingList(
        3, 'assets/images/NavbarImage/setting.png', "Admin Settings"));
  }

  void onchange(index) {
    // This is called when the user toggles the switch.
    _selected = !_selected;
    selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Setting',
                      style: TextStyle(
                        color: theme.primary,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: double.infinity, height: 16),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: listlvmenu.length,
                          itemBuilder: (BuildContext context, int index) {
                            dynamic objkey = listlvmenu.elementAt(index);
                            return ListTile(
                              tileColor: selectedIndex == index
                                  ? theme.onBackground
                                  : null,
                              onTap: () {
                                onchange(index);
                                setState(() {
                                  itemnow = objkey;
                                });
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              leading: ImageIcon(AssetImage(objkey.icon),
                                  color: selectedIndex == index
                                      ? theme.background
                                      : theme.onPrimary),
                              title: Text(objkey.title.toString()),
                              titleTextStyle: TextStyle(
                                color: selectedIndex == index
                                    ? theme.background
                                    : theme.onPrimary,
                                fontSize: 24,
                                fontFamily: 'Noto Sans Thai',
                                fontWeight: FontWeight.w700,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          padding: const EdgeInsets.all(32),
                          margin: const EdgeInsets.only(
                              left: 10.0, right: 15.0, bottom: 15),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: theme.background,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
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
                          child: Settinglistbymenulistitem(
                            items: itemnow,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
