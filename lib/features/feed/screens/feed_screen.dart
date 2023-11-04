import 'package:employee_forums/features/feed/providers/feed_provider.dart';
import 'package:employee_forums/models/post.dart';
import 'package:flutter/material.dart';

import '../../../common/colors/colors.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final FeedProvider feedProvider = FeedProvider();
  final ScrollController postsScrollController = ScrollController();

  @override
  void initState() {
    feedProvider.getPostsPage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Post> posts = feedProvider.posts;
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Expanded(
                  child: SearchBar(
                    leading: Icon(
                      Icons.search,
                      color: AppColors.greyTextColor,
                    ),
                    hintText: "Search Messages",
                  ),
                ),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                    child: Image.asset(
                      "assets/icons/filter.png",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: postsScrollController,
              padding: const EdgeInsets.all(15),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Container(
                  height: screenHeight * 0.4,
                  color: AppColors.white,
                  child: const Column(
                    children: [],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
