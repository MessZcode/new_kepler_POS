import 'package:flutter/material.dart';

class SettingAppViewModel with ChangeNotifier {
  final List<String> list = <String>[
    'setting users',
    'setting category',
    'setting discount',
    'setting menu'
  ];
}