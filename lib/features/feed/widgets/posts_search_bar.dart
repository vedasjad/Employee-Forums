import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/colors/colors.dart';
import '../../../common/utils/snack_bar.dart';
import '../../../models/post.dart';
import '../../searchedPosts/screens/searched_posts_screen.dart';
import '../providers/feed_provider.dart';

class PostsSearchBar extends StatelessWidget {
  PostsSearchBar({
    super.key,
  });

  final TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: searchTextController,
      onSubmitted: (searchText) {
        if (searchText.isEmpty) {
          showSnackBar(context, "Type something to search");
          return;
        }
        List<Post> filteredPosts =
            Provider.of<FeedProvider>(context, listen: false)
                .posts
                .where(
                  (Post product) =>
                      product.title.toLowerCase().contains(
                            searchText.toLowerCase(),
                          ) ||
                      product.description.toLowerCase().contains(
                            searchText.toLowerCase(),
                          ) ||
                      product.eventCategory.toLowerCase().contains(
                            searchText.toLowerCase(),
                          ),
                )
                .toList();
        Set<Post> filteredPostsSet = filteredPosts.toSet();
        filteredPosts = filteredPostsSet.toList();
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              final curve =
                  CurvedAnimation(parent: animation, curve: Curves.ease);
              var tween = Tween(begin: begin, end: end);
              var offsetAnimation = tween.animate(curve);
              return SlideTransition(
                position: offsetAnimation,
                child: SearchedPostsScreen(
                  filteredPosts: filteredPosts,
                  searchText: searchText,
                ),
              );
            },
          ),
        );
      },
      leading: const Icon(
        Icons.search,
        color: AppColors.charcoalGrey,
      ),
      trailing: [
        searchTextController.text.isNotEmpty
            ? GestureDetector(
                onTap: () => searchTextController.clear(),
                child: const Icon(
                  Icons.clear,
                  size: 25,
                  color: AppColors.charcoalGrey,
                ),
              )
            : const SizedBox(),
      ],
      hintText: "Search Posts",
    );
  }
}
