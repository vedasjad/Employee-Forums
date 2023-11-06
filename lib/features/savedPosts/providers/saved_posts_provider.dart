import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../common/hive/hive_boxes.dart';
import '../../../models/post.dart';

class SavedPostsProvider extends ChangeNotifier {
  bool _isScrollView = false;

  final List<Post> _savedPosts = [];
  void toggleScrollView() {
    _isScrollView = !_isScrollView;
    notifyListeners();
  }

  void getSavedPosts() {
    Box savedPostsBox = Hive.box(HiveBoxes.savedPosts);
    _savedPosts.clear();
    for (int i = 0; i < savedPostsBox.length; i++) {
      _savedPosts.add(savedPostsBox.getAt(i));
    }
    notifyListeners();
  }

  get isScrollView => _isScrollView;
  get savedPosts => _savedPosts;
}
