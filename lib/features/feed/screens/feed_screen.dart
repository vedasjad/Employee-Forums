import 'package:employee_forums/features/feed/providers/feed_provider.dart';
import 'package:employee_forums/features/searchedPosts/screens/searched_posts_screen.dart';
import 'package:employee_forums/models/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/colors/colors.dart';
import '../../../common/utils/snack_bar.dart';
import '../widgets/post_widget.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final ScrollController postsScrollController = ScrollController();
  final TextEditingController searchTextController = TextEditingController();
  @override
  void initState() {
    context.read<FeedProvider>().getPostsPage(context);
    postsScrollController.addListener(() {
      if (postsScrollController.position.maxScrollExtent <=
          postsScrollController.position.pixels) {
        context.read<FeedProvider>().getPostsPage(context);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    postsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Post> posts = context.watch<FeedProvider>().posts;
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.grey.withOpacity(0.7),
                  width: 3,
                ),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
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
                                    product.eventCategory
                                        .toLowerCase()
                                        .contains(
                                          searchText.toLowerCase(),
                                        ),
                              )
                              .toList();
                      Set<Post> filteredPostsSet = filteredPosts.toSet();
                      filteredPosts.clear();
                      filteredPosts = filteredPostsSet.toList();
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
                  ),
                ),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Image.asset(
                      "assets/icons/filter.png",
                      height: 35,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: postsScrollController,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PostWidget(index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
