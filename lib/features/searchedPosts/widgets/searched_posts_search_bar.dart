import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/colors/colors.dart';
import '../../../common/utils/snack_bar.dart';
import '../../../models/post.dart';
import '../../feed/providers/feed_provider.dart';
import '../screens/searched_posts_screen.dart';

class SearchedPostsSearchBar extends StatelessWidget {
  const SearchedPostsSearchBar({
    super.key,
    required this.searchTextController,
    required this.searchText,
  });

  final TextEditingController searchTextController;
  final String searchText;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: searchTextController,
      onSubmitted: (searchTextSubmitted) {
        if (searchTextSubmitted.isEmpty) {
          showSnackBar(context, "Type something to search");
          return;
        }
        if (searchTextSubmitted == searchText) {
          showSnackBar(context, "Type something different");
          return;
        }
        List<Post> filteredPosts =
            Provider.of<FeedProvider>(context, listen: false)
                .posts
                .where(
                  (Post product) =>
                      product.title.toLowerCase().contains(
                            searchTextSubmitted.toLowerCase(),
                          ) ||
                      product.description.toLowerCase().contains(
                            searchTextSubmitted.toLowerCase(),
                          ) ||
                      product.eventCategory.toLowerCase().contains(
                            searchTextSubmitted.toLowerCase(),
                          ),
                )
                .toList();
        Set<Post> filteredPostsSet = filteredPosts.toSet();
        filteredPosts.clear();
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
                  searchText: searchTextSubmitted,
                ),
              );
            },
          ),
        );
      },
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      elevation: const MaterialStatePropertyAll(0),
      backgroundColor: const MaterialStatePropertyAll(AppColors.coldWhite),
      leading: const Icon(
        Icons.search,
        color: AppColors.charcoalGrey,
      ),
      trailing: [
        GestureDetector(
          onTap: () => searchTextController.clear(),
          child: const Icon(
            Icons.clear,
            size: 25,
            color: AppColors.charcoalGrey,
          ),
        )
      ],
      hintText: "Search Posts",
      hintStyle: const MaterialStatePropertyAll(
        TextStyle(
          fontSize: 17,
        ),
      ),
    );
  }
}
