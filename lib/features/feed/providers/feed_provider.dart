import 'package:employee_forums/common/hive/hive_boxes.dart';
import 'package:employee_forums/features/feed/services/feed_services.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../models/post.dart';

class FeedProvider extends ChangeNotifier {
  final List<Post> _posts = [];
  final Box _likedPosts = Hive.box(HiveBoxes.likedPosts);
  final Box _savedPosts = Hive.box(HiveBoxes.savedPosts);
  int _currentPage = 0;
  final FeedServices _feedServices = FeedServices();

  void getPostsPage(BuildContext context) async {
    List<Post> newPosts =
        await _feedServices.getPostsPage(context, _currentPage);
    _posts.addAll(newPosts);
    notifyListeners();
    _currentPage++;
  }

  void togglePostLike(int index, Post post) {
    _likedPosts.containsKey(index)
        ? _likedPosts.delete(index)
        : _likedPosts.put(index, post);
    notifyListeners();
  }

  void togglePostSave(int index, Post post) {
    _savedPosts.containsKey(index)
        ? _savedPosts.delete(index)
        : _savedPosts.put(index, post);
    notifyListeners();
  }

  get posts => _posts;
}
