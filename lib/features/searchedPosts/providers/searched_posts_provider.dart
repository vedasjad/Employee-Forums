import 'package:flutter/material.dart';

class SavedPostsProvider extends ChangeNotifier {
  bool _isScrollView = false;

  void toggleScrollView() {
    _isScrollView = !_isScrollView;
    notifyListeners();
  }

  get isScrollView => _isScrollView;
}
