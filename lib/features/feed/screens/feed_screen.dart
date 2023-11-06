import 'package:employee_forums/features/feed/providers/feed_provider.dart';
import 'package:employee_forums/models/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/colors/colors.dart';
import '../widgets/post_widget.dart';
import '../widgets/posts_search_bar.dart';
import '../widgets/select_category_widget.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final ScrollController postsScrollController = ScrollController();
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
    final List<Post> selectedCategoryPosts =
        context.watch<FeedProvider>().selectedCategoryPosts;
    final String selectedCategory =
        context.watch<FeedProvider>().selectedCategory;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
                  child: PostsSearchBar(),
                ),
                selectedCategoryPosts.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/icons/filter.png",
                              height: 35,
                            ),
                            Text(
                              selectedCategory,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.charcoalGrey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return const SelectCategoryWidget();
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/icons/filter.png",
                                height: 35,
                              ),
                              Text(
                                selectedCategory,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppColors.charcoalGrey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
          selectedCategoryPosts.isEmpty
              ? Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: AppColors.grey.withOpacity(0.7),
                              width: 7,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Icon(
                                          Icons.person,
                                          color: AppColors.grey,
                                          size: 25,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 150,
                                              height: 8,
                                              color: AppColors.grey,
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.only(top: 5),
                                              width: 50,
                                              height: 5,
                                              color: AppColors.grey,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.more_horiz_rounded,
                                    color: AppColors.grey,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: screenWidth,
                              width: screenWidth,
                              color: AppColors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(8),
                                  height: 10,
                                  width: screenWidth * 0.7,
                                  color: AppColors.grey,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(8),
                                  height: 10,
                                  width: screenWidth * 0.2,
                                  color: AppColors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    controller: postsScrollController,
                    itemCount: selectedCategoryPosts.length,
                    itemBuilder: (context, index) {
                      int postIndex =
                          posts.indexOf(selectedCategoryPosts[index]);
                      return PostWidget(index: postIndex);
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
