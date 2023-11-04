import 'package:employee_forums/features/community/screens/community_screen.dart';
import 'package:employee_forums/features/feed/screens/feed_screen.dart';
import 'package:employee_forums/features/home/providers/home_provider.dart';
import 'package:employee_forums/features/liked/screens/liked_screen.dart';
import 'package:employee_forums/features/saved/screens/saved_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> screens = const [
    FeedScreen(),
    LikedScreen(),
    CommunityScreen(),
    SavedScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
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
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_filled,
                  ),
                  label: "Feed",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_rounded,
                  ),
                  label: "Liked",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.people,
                  ),
                  label: "Community",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.bookmark_border_rounded,
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
