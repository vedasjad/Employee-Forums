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
                GestureDetector(
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
          Expanded(
            child: ListView.builder(
              controller: postsScrollController,
              itemCount: selectedCategoryPosts.length,
              itemBuilder: (context, index) {
                int postIndex = posts.indexOf(selectedCategoryPosts[index]);
                return PostWidget(index: postIndex);
              },
            ),
          ),
        ],
      ),
    );
  }
}
