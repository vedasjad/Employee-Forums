import 'package:employee_forums/features/feed/providers/feed_provider.dart';
import 'package:employee_forums/models/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/colors/colors.dart';
import '../../feed/widgets/post_widget.dart';
import '../widgets/searched_posts_search_bar.dart';

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
          child: SearchedPostsSearchBar(
            searchTextController: searchTextController,
            searchText: widget.searchText,
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
            return PostWidget(
              post: post,
            );
          },
        ),
      ),
    );
  }
}
