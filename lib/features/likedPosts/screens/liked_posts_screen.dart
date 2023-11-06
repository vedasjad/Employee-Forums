import 'package:employee_forums/features/likedPosts/screens/liked_posts_scroll_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../common/hive/hive_boxes.dart';

class LikedPostsScreen extends StatefulWidget {
  const LikedPostsScreen({super.key});

  @override
  State<LikedPostsScreen> createState() => _LikedPostsScreenState();
}

class _LikedPostsScreenState extends State<LikedPostsScreen> {
  final Box likedPosts = Hive.box(HiveBoxes.likedPosts);
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
          height: screenHeight,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Liked Posts",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: likedPosts.length,
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
                                child: const LikedPostsScrollScreen(),
                              );
                            },
                          ),
                        );
                      },
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
                          likedPosts.getAt(index).image.first,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
