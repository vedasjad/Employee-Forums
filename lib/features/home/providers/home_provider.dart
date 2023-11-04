import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int _selectedBottomNavigationBarItemIndex = 0;

  void updateSelectedBottomNavigationBarItemIndex(int newIndex) {
    _selectedBottomNavigationBarItemIndex = newIndex;
    notifyListeners();
  }

  get selectedBottomNavigationBarItemIndex =>
      _selectedBottomNavigationBarItemIndex;
}
