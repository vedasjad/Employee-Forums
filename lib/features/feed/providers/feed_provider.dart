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

  void togglePostLike(Post post) {
    _likedPosts.containsKey(post.id)
        ? _likedPosts.delete(post.id)
        : _likedPosts.put(post.id, post);
    notifyListeners();
  }

  void togglePostSave(Post post) {
    _savedPosts.containsKey(post.id)
        ? _savedPosts.delete(post.id)
        : _savedPosts.put(post.id, post);
    notifyListeners();
  }

  get posts => _posts;
}
