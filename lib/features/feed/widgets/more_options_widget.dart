import 'package:employee_forums/features/feed/providers/feed_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../common/colors/colors.dart';
import '../../../common/hive/hive_boxes.dart';
import '../../../models/post.dart';

class MoreOptionsWidget extends StatelessWidget {
  MoreOptionsWidget({
    super.key,
    required this.post,
  });

  final Post post;

  final Box savedPosts = Hive.box(HiveBoxes.savedPosts);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 210,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListView(
        children: [
          Divider(
            height: 15,
            thickness: 4,
            color: AppColors.black,
            indent: screenWidth * 0.45,
            endIndent: screenWidth * 0.45,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      context
                          .read<FeedProvider>()
                          .togglePostSave(post, context);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2,
                          color: AppColors.black,
                        ),
                      ),
                      child:
                          savedPosts.containsKey(post.userId + post.createdAt)
                              ? const Icon(
                                  Icons.bookmark_added,
                                  size: 35,
                                )
                              : const Icon(
                                  Icons.bookmark_border,
                                  size: 35,
                                ),
                    ),
                  ),
                  savedPosts.containsKey(post.userId + post.createdAt)
                      ? const Text(
                          "Saved",
                        )
                      : const Text(
                          "Save",
                        ),
                ],
              ),
            ],
          ),
          const Divider(
            thickness: 0.5,
            color: AppColors.black,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.account_circle_outlined,
                    size: 35,
                  ),
                ),
                Text(
                  "About this account",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.report_outlined,
                    size: 35,
                    color: Colors.red,
                  ),
                ),
                Text(
                  "Report",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
