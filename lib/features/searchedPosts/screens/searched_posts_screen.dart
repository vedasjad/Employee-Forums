import 'package:employee_forums/features/searchedPosts/screens/searched_posts_scroll_screen.dart';
import 'package:flutter/material.dart';

import '../../../common/colors/colors.dart';
import '../../../models/post.dart';
import '../widgets/searched_posts_search_bar.dart';

class SearchedPostsScreen extends StatelessWidget {
  SearchedPostsScreen({
    super.key,
    required this.filteredPosts,
    required this.searchText,
  });
  final List<Post> filteredPosts;
  final String searchText;
  final TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    searchTextController.text = searchText;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: AppColors.coldWhite,
        title: Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(0, 15, 10, 15),
          child: SearchedPostsSearchBar(
              searchTextController: searchTextController,
              searchText: searchText),
        ),
      ),
      body: SizedBox(
        height: screenHeight,
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: filteredPosts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
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
                              child: SearchedPostsScrollScreen(
                                searchText: searchText,
                                filteredPosts: filteredPosts,
                              ),
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: screenWidth / 1.7,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      margin: const EdgeInsets.all(8),
                      child: Image.network(
                        filteredPosts[index].image.first,
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
