import 'package:flutter/material.dart';

class GridStyleLogic extends ChangeNotifier {
  bool _gridStyle = true;
  bool get gridStyle => _gridStyle;

  void toggleStyle() {
    _gridStyle = !_gridStyle;
    notifyListeners();
  }
}