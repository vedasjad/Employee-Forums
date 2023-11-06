import 'package:employee_forums/features/feed/providers/feed_provider.dart';
import 'package:employee_forums/models/post.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../common/hive/hive_boxes.dart';
import '../../feed/widgets/post_widget.dart';

class LikedPostsScrollScreen extends StatefulWidget {
  const LikedPostsScrollScreen({super.key});

  @override
  State<LikedPostsScrollScreen> createState() => _LikedPostsScrollScreenState();
}

class _LikedPostsScrollScreenState extends State<LikedPostsScrollScreen> {
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

  final Box likedPosts = Hive.box(HiveBoxes.likedPosts);
  @override
  Widget build(BuildContext context) {
    final List<Post> posts = context.watch<FeedProvider>().posts;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liked Posts"),
      ),
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: ListView.builder(
          controller: postsScrollController,
          itemCount: likedPosts.length,
          itemBuilder: (context, index) {
            Post post = posts.firstWhere(
              (element) => element == likedPosts.getAt(index),
            );
            return PostWidget(index: posts.indexOf(post));
          },
        ),
      ),
    );
  }
}
