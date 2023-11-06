import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../common/hive/hive_boxes.dart';
import '../../../models/post.dart';

class LikedPostsProvider extends ChangeNotifier {
  bool _isScrollView = false;
  final List<Post> _likedPosts = [];

  void toggleScrollView() {
    _isScrollView = !_isScrollView;
    notifyListeners();
  }

  void getLikedPosts() {
    Box likedPostsBox = Hive.box(HiveBoxes.likedPosts);
    _likedPosts.clear();
    for (int i = 0; i < likedPostsBox.length; i++) {
      _likedPosts.add(likedPostsBox.getAt(i));
    }
    notifyListeners();
  }

  get isScrollView => _isScrollView;
  get likedPosts => _likedPosts;
}
