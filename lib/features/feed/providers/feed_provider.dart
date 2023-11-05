import 'package:employee_forums/features/feed/services/feed_services.dart';
import 'package:flutter/material.dart';

import '../../../common/utils/snack_bar.dart';
import '../../../models/post.dart';

class FeedProvider extends ChangeNotifier {
  final List<Post> _posts = [];
  int _currentPage = 0;

  FeedServices feedServices = FeedServices();

  void getPostsPage(BuildContext context) async {
    _currentPage++;
    List<Post> newPosts =
        await feedServices.getPostsPage(context, _currentPage);
    newPosts.isEmpty
        ? showSnackBar(context, "No More Posts")
        : _posts.addAll(newPosts);
    notifyListeners();
  }

  get posts => _posts;
}
