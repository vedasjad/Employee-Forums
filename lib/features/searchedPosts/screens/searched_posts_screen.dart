import 'package:employee_forums/features/searchedPosts/screens/searched_posts_scroll_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/colors/colors.dart';
import '../../../common/utils/snack_bar.dart';
import '../../../models/post.dart';
import '../../feed/providers/feed_provider.dart';

class SearchedPostsScreen extends StatefulWidget {
  const SearchedPostsScreen({
    super.key,
    required this.filteredPosts,
    required this.searchText,
  });
  final List<Post> filteredPosts;
  final String searchText;
  @override
  State<SearchedPostsScreen> createState() => _SearchedPostsScreenState();
}

class _SearchedPostsScreenState extends State<SearchedPostsScreen> {
  TextEditingController searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    searchTextController.text = widget.searchText;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: AppColors.coldWhite,
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
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: widget.filteredPosts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
                            final curve = CurvedAnimation(
                                parent: animation, curve: Curves.ease);
                            var tween = Tween(begin: begin, end: end);
                            var offsetAnimation = tween.animate(curve);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: SearchedPostsScrollScreen(
                                searchText: widget.searchText,
                                filteredPosts: widget.filteredPosts,
                              ),
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: screenWidth / 1.7,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      margin: const EdgeInsets.all(8),
                      child: Image.network(
                        widget.filteredPosts[index].image.first,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
