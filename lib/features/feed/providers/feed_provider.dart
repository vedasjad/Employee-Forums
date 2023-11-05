import 'package:employee_forums/common/hive/hive_boxes.dart';
import 'package:employee_forums/features/feed/services/feed_services.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../models/post.dart';

class FeedProvider extends ChangeNotifier {
  final List<Post> _posts = [];
  final Box likedPosts = Hive.box(HiveBoxes.likedPosts);
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
    likedPosts.containsKey(post.id)
        ? likedPosts.delete(post.id)
        : likedPosts.put(post.id, post);
    notifyListeners();
  }

  get posts => _posts;
}
