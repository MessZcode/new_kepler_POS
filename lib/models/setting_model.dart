class Mode {
  late int id;
  late String Color;
  late String title;
  late String group;
  late bool selected;

  Mode(this.id, this.Color, this.title, this.group, this.selected);
}

class History {
  late int id;
  late DateTime datetime;
  late double timecurrent;

  History(this.id, this.datetime, this.timecurrent);
}

class MenuSettingList {
  late int id;
  late String icon;
  late String title;

  MenuSettingList(this.id, this.icon, this.title);
}
