import 'package:employee_forums/common/hive/hive_boxes.dart';
import 'package:employee_forums/features/feed/services/feed_services.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../models/post.dart';
import '../../likedPosts/providers/liked_posts_provider.dart';
import '../../savedPosts/providers/saved_posts_provider.dart';

class FeedProvider extends ChangeNotifier {
  final List<Post> _posts = [];
  List<String> _categories = ["All"];
  String _selectedCategory = "All";
  final List<Post> _selectedCategoryPosts = [];

  final Box _likedPosts = Hive.box(HiveBoxes.likedPosts);
  final Box _savedPosts = Hive.box(HiveBoxes.savedPosts);
  int _currentPage = 0;
  final FeedServices _feedServices = FeedServices();

  void getPostsPage(BuildContext context) async {
    List<Post> newPosts =
        await _feedServices.getPostsPage(context, _currentPage);
    _posts.addAll(newPosts);
    _categories.addAll(
        List.generate(_posts.length, (index) => _posts[index].eventCategory));
    _categories = _categories.toSet().toList();
    updateCategory(_selectedCategory);
    notifyListeners();
    if (newPosts.isNotEmpty) _currentPage++;
  }

  void togglePostLike(Post post, BuildContext context) {
    _likedPosts.containsKey(post.userId + post.createdAt)
        ? _likedPosts.delete(post.userId + post.createdAt)
        : _likedPosts.put(post.userId + post.createdAt, post);
    context.read<LikedPostsProvider>().getLikedPosts();
    notifyListeners();
  }

  void togglePostSave(Post post, BuildContext context) {
    _savedPosts.containsKey(post.userId + post.createdAt)
        ? _savedPosts.delete(post.userId + post.createdAt)
        : _savedPosts.put(post.userId + post.createdAt, post);
    context.read<SavedPostsProvider>().getSavedPosts();
    notifyListeners();
  }

  void updateCategory(String category) {
    _selectedCategory = category;
    _selectedCategoryPosts.clear();
    _selectedCategoryPosts.addAll(_selectedCategory == _categories.first
        ? _posts
        : _posts
            .where((element) => element.eventCategory == _selectedCategory)
            .toList());
    notifyListeners();
  }

  get posts => _posts;
  get categories => _categories;
  get selectedCategory => _selectedCategory;
  get selectedCategoryPosts => _selectedCategoryPosts;
}
