import 'package:flutter/material.dart';

class LikedPostsProvider extends ChangeNotifier{
  bool _isScrollView = false;

  void toggleScrollView(){
    _isScrollView = !_isScrollView;
    notifyListeners();
  }

  get isScrollView => _isScrollView;
}