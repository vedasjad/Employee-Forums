import 'package:employee_forums/features/feed/providers/feed_provider.dart';
import 'package:employee_forums/models/post.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../common/hive/hive_boxes.dart';
import '../../feed/widgets/post_widget.dart';

class SavedPostsScrollScreen extends StatefulWidget {
  const SavedPostsScrollScreen({super.key});

  @override
  State<SavedPostsScrollScreen> createState() => _SavedPostsScrollScreenState();
}

class _SavedPostsScrollScreenState extends State<SavedPostsScrollScreen> {
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

  final Box savedPosts = Hive.box(HiveBoxes.savedPosts);
  @override
  Widget build(BuildContext context) {
    final List<Post> posts = context.watch<FeedProvider>().posts;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Posts"),
      ),
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: ListView.builder(
          controller: postsScrollController,
          itemCount: savedPosts.length,
          itemBuilder: (context, index) {
            Post post = posts.firstWhere(
              (element) => element == savedPosts.getAt(index),
            );
            return PostWidget(index: posts.indexOf(post));
          },
        ),
      ),
    );
  }
}