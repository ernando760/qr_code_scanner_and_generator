import 'package:flutter/material.dart';

class BottomNavigationController extends ChangeNotifier {
  int _indexCurrent = 0;

  int get indexCurrent => _indexCurrent;

  void change(int newindexCurrent) {
    _indexCurrent = newindexCurrent;
    notifyListeners();
  }
}
