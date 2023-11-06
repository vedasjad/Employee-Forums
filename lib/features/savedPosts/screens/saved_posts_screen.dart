import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../common/colors/colors.dart';
import '../../../common/hive/hive_boxes.dart';
import '../../../models/post.dart';
import '../../feed/providers/feed_provider.dart';
import '../../feed/widgets/post_widget.dart';
import '../../searchedPosts/providers/searched_posts_provider.dart';

class SavedPostsScreen extends StatelessWidget {
  SavedPostsScreen({super.key});

  final Box savedPosts = Hive.box(HiveBoxes.savedPosts);

  @override
  Widget build(BuildContext context) {
    final List<Post> posts = context.watch<FeedProvider>().posts;
    bool isScrollView = context.watch<SavedPostsProvider>().isScrollView;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: screenHeight,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Saved Posts",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        context.read<SavedPostsProvider>().toggleScrollView(),
                    child: Icon(
                      isScrollView ? Icons.grid_view_rounded : Icons.view_list,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
            isScrollView
                ? Expanded(
                    child: ListView.builder(
                      itemCount: savedPosts.length,
                      itemBuilder: (context, index) {
                        Post post = posts.firstWhere(
                          (element) => element == savedPosts.getAt(index),
                        );
                        return PostWidget(index: posts.indexOf(post));
                      },
                    ),
                  )
                : Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: savedPosts.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => context
                              .read<SavedPostsProvider>()
                              .toggleScrollView(),
                          child: Container(
                            width: screenWidth / 2.5,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            margin: const EdgeInsets.all(2),
                            child: Image.network(
                              savedPosts.getAt(index).image.first,
                              fit: BoxFit.fill,
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
