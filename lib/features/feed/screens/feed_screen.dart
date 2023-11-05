import 'package:employee_forums/features/feed/providers/feed_provider.dart';
import 'package:employee_forums/models/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/colors/colors.dart';
import '../widgets/post_widget.dart';

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
                const Expanded(
                  child: SearchBar(
                    leading: Icon(
                      Icons.search,
                      color: AppColors.charcoalGrey,
                    ),
                    hintText: "Search Messages",
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
