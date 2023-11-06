import 'package:employee_forums/common/colors/colors.dart';
import 'package:employee_forums/features/community/screens/community_screen.dart';
import 'package:employee_forums/features/feed/screens/feed_screen.dart';
import 'package:employee_forums/features/home/providers/home_provider.dart';
import 'package:employee_forums/features/likedPosts/screens/liked_posts_screen.dart';
import 'package:employee_forums/features/savedPosts/screens/saved_posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Widget> screens = [
    const FeedScreen(),
    LikedPostsScreen(),
    const CommunityScreen(),
    SavedPostsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(
            Icons.menu,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Employee Forum",
        ),
        actions: [
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(
                Icons.notifications_none_outlined,
              ),
            ),
          ),
        ],
      ),
      body: screens[homeProvider.selectedBottomNavigationBarItemIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.black.withOpacity(0.8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BottomNavigationBar(
              onTap: (index) => homeProvider
                  .updateSelectedBottomNavigationBarItemIndex(index),
              currentIndex: homeProvider.selectedBottomNavigationBarItemIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/home.png",
                    height: 30,
                    width: 30,
                    color:
                        homeProvider.selectedBottomNavigationBarItemIndex == 0
                            ? AppColors.blue
                            : AppColors.white,
                  ),
                  label: "Feed",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/liked.png",
                    height: 30,
                    width: 30,
                    color:
                        homeProvider.selectedBottomNavigationBarItemIndex == 1
                            ? AppColors.blue
                            : AppColors.white,
                  ),
                  label: "Liked",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/community.png",
                    height: 30,
                    width: 30,
                    color:
                        homeProvider.selectedBottomNavigationBarItemIndex == 2
                            ? AppColors.blue
                            : AppColors.white,
                  ),
                  label: "Community",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/bookmark.png",
                    height: 30,
                    width: 30,
                    color:
                        homeProvider.selectedBottomNavigationBarItemIndex == 3
                            ? AppColors.blue
                            : AppColors.white,
                  ),
                  label: "Saved",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
