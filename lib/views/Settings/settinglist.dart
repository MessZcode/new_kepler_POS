import 'dart:developer';
//
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/theme_viewmodel.dart';
import '../../models/setting_model.dart';

class Settinglistbymenulistitem extends StatefulWidget {
  final dynamic items;

  const Settinglistbymenulistitem({
    super.key,
    this.items,
  });

  @override
  State<Settinglistbymenulistitem> createState() => _SettinglistbymenulistitemState();
}

class _SettinglistbymenulistitemState extends State<Settinglistbymenulistitem> {
  List<History> listhistory = [];
  late int radiothememode = 1;
  List<Mode> listmodemap = [];

  @override
  void initState() {
    super.initState();
    AddList();
  }

  void AddList() {
    listhistory.add(History(1, DateTime.now(), 0.50));
    listhistory.add(History(2, DateTime.now(), 1.59));
    listhistory.add(History(3, DateTime.now(), 2.58));
    listhistory.add(History(4, DateTime.now(), 3.45));
    listhistory.add(History(5, DateTime.now(), 4.30));
    listhistory.add(History(6, DateTime.now(), 5.30));
    listhistory.add(History(7, DateTime.now(), 6.00));

    listmodemap.add(Mode(1, "0xFF1CAF82", "Green", "theme", true));
    listmodemap.add(Mode(2, "0xFF1CAF82", "Dark", "theme", true));
  }

  @override
  Widget build(BuildContext context) {
    final Themeviewmodel them = Provider.of<Themeviewmodel>(context);
    final theme = Theme.of(context).colorScheme;
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: ShapeDecoration(
                // color: Colors.deepOrangeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: widget.items.id == 1
                  ? Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.items.title.toString(),
                          style: TextStyle(
                            color: theme.primary,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: ShapeDecoration(
                            color: theme.onError,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            child: Container(
                                              width: 80,
                                              height: 80,
                                              alignment: Alignment.center,
                                              decoration: ShapeDecoration(
                                                color: theme.onBackground,
                                                shape: OvalBorder(
                                                  side: BorderSide(width: 1, color: theme.background),
                                                ),
                                                shadows: const [
                                                  BoxShadow(
                                                    color: Color(0x0F000000),
                                                    blurRadius: 4,
                                                    offset: Offset(0, 2),
                                                    spreadRadius: -1,
                                                  ),
                                                  BoxShadow(
                                                    color: Color(0x19000000),
                                                    blurRadius: 6,
                                                    offset: Offset(0, 4),
                                                    spreadRadius: -1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 80,
                                              height: 80,
                                              child: Text(
                                                'P',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: theme.background,
                                                  fontSize: 48,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 50),
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Parida Jomjai',
                                            style: TextStyle(
                                              color: theme.onBackground,
                                              fontSize: 32,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            'Admin',
                                            style: TextStyle(
                                              color: theme.onSurface,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '0.50 Hours',
                                        style: TextStyle(
                                          // color: Color(0xFF252525),
                                          fontSize: 32,
                                          fontFamily: 'Noto Sans Thai',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'On clock',
                                        style: TextStyle(
                                          color: Color(0xFFA6B4BA),
                                          fontSize: 24,
                                          fontFamily: 'Noto Sans Thai',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                        const Text(
                          'History',
                          style: TextStyle(
                            // color: Color(0xFF252525),
                            fontSize: 24,
                            fontFamily: 'Noto Sans Thai',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GridView.count(
                              crossAxisCount: 1,
                              childAspectRatio: (1 / .09),
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0,
                              shrinkWrap: true,
                              children: listhistory
                                  .map(
                                    (e) => Card(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              DateFormat.yMd().format(DateTime.parse(e.datetime.toString())),
                                              style: const TextStyle(
                                                // color: Color(0xFF252525),
                                                fontSize: 24,
                                                fontFamily: 'Noto Sans Thai',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              DateFormat.Hm().format(DateTime.parse(e.datetime.toString())),
                                              style: const TextStyle(
                                                // color: Color(0xFF252525),
                                                fontSize: 24,
                                                fontFamily: 'Noto Sans Thai',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "${e.timecurrent.toString().padRight(4, '0')} Hours",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: theme.secondary,
                                                fontSize: 24,
                                                fontFamily: 'Noto Sans Thai',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList()),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.items.title.toString(),
                          style: const TextStyle(
                            // color: Color(0xFF252525),
                            fontSize: 24,
                            fontFamily: 'Noto Sans Thai',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          margin: const EdgeInsets.only(top: 15),
                          decoration: ShapeDecoration(
                            color: Theme.of(context).canvasColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Dark Mode',
                                style: TextStyle(
                                  color: theme.onPrimary,
                                  fontSize: 24,
                                  fontFamily: 'Noto Sans Thai',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.only(top: 18),
                                  width: double.infinity,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                    child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: listmodemap
                                            .map(
                                              (e) => SizedBox(
                                                width: 200,
                                                child: RadioListTile(
                                                  // contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                                                  // dense: true,
                                                  value: e.id,
                                                  title: Text(
                                                    e.title,
                                                    style: const TextStyle(
                                                      // color: Theme.of(context),
                                                      fontSize: 24,
                                                      fontFamily: 'Noto Sans Thai',
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  groupValue: them.idselect,
                                                  toggleable: true,
                                                  // activeColor: Colors.green,
                                                  // hoverColor: Colors.green,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      them.tapchangeTheme(e.id);
                                                      print('select number ${e.id}');
                                                      for (int i = 0; i < listmodemap.length; i++) {
                                                        listmodemap[i].selected = false;
                                                      }
                                                      try {
                                                        radiothememode = val!;
                                                      } catch (e) {
                                                        print('Something really unknown: $e');
                                                      }
                                                      e.selected = true;
                                                      inspect(listmodemap);
                                                    });
                                                  },
                                                  controlAffinity: ListTileControlAffinity.leading,
                                                ),
                                              ),
                                            )
                                            .toList()),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }
}
