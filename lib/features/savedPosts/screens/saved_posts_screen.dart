import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/colors/colors.dart';
import '../../../models/post.dart';
import '../../feed/widgets/post_widget.dart';
import '../providers/saved_posts_provider.dart';

class SavedPostsScreen extends StatelessWidget {
  const SavedPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Post> savedPosts =
        context.watch<SavedPostsProvider>().savedPosts;
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
                        return PostWidget(post: savedPosts[index]);
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
                              savedPosts[index].image.first,
                              fit: BoxFit.cover,
                              errorBuilder: (context, child, loadingProgress) {
                                return Container(
                                  height: screenWidth / 2.5,
                                  width: screenWidth / 2.5,
                                  color: AppColors.grey,
                                  child: const Center(
                                    child: Text(
                                      'Image Not Found',
                                      style: TextStyle(
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                );
                              },
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
