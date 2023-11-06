import 'package:employee_forums/common/utils/snack_bar.dart';
import 'package:employee_forums/features/feed/providers/feed_provider.dart';
import 'package:employee_forums/features/searchedPosts/screens/searched_posts_screen.dart';
import 'package:employee_forums/models/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/colors/colors.dart';
import '../../feed/widgets/post_widget.dart';

class SearchedPostsScrollScreen extends StatefulWidget {
  const SearchedPostsScrollScreen({
    super.key,
    required this.searchText,
    required this.filteredPosts,
  });
  final List<Post> filteredPosts;
  final String searchText;

  @override
  State<SearchedPostsScrollScreen> createState() =>
      _SearchedPostsScrollScreenState();
}

class _SearchedPostsScrollScreenState extends State<SearchedPostsScrollScreen> {
  final ScrollController postsScrollController = ScrollController();
  @override
  void initState() {
    postsScrollController.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    postsScrollController.dispose();
    super.dispose();
  }

  final TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<Post> posts = context.watch<FeedProvider>().posts;
    searchTextController.text = widget.searchText;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: AppColors.white,
        title: Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(0, 15, 10, 15),
          child: SearchBar(
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
                        searchText: searchText,
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
            backgroundColor:
                const MaterialStatePropertyAll(AppColors.coldWhite),
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
          ),
        ),
      ),
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: ListView.builder(
          controller: postsScrollController,
          itemCount: widget.filteredPosts.length,
          itemBuilder: (context, index) {
            Post post = posts.firstWhere(
              (element) => element == widget.filteredPosts[index],
            );
            return PostWidget(index: posts.indexOf(post));
          },
        ),
      ),
    );
  }
}
