import 'MenuHolder.dart';
import 'MenuItem.dart';
import 'dart:html';

class Hunt extends MenuItem {
  Hunt(MenuHolder holder) : super("Hunt", holder);

  @override
  void onClick() {
    window.alert("TODO");
  }
}