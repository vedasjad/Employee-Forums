import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../common/colors/colors.dart';
import '../../../common/hive/hive_boxes.dart';
import '../../../models/post.dart';
import '../providers/feed_provider.dart';

class OptionsWidget extends StatelessWidget {
  OptionsWidget({
    super.key,
    required this.post,
    required this.index,
  });

  final Post post;
  final int index;

  final Box likedPosts = Hive.box(HiveBoxes.likedPosts);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.grey,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () =>
                context.read<FeedProvider>().togglePostLike(index, post),
            child: Row(
              children: [
                likedPosts.containsKey(index)
                    ? const Icon(
                        Icons.thumb_up_rounded,
                        color: AppColors.blue,
                        size: 20,
                      )
                    : const Icon(
                        Icons.thumb_up_alt_outlined,
                        color: AppColors.charcoalGrey,
                      ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "${likedPosts.containsKey(index) ? post.likes + 1 : post.likes} Likes",
                    style: const TextStyle(
                      color: AppColors.charcoalGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Image.asset(
                "assets/icons/comment.png",
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "${post.noOfComments} Comments",
                  style: const TextStyle(
                    color: AppColors.charcoalGrey,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Image.asset(
                "assets/icons/share.png",
              ),
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  "Share",
                  style: TextStyle(
                    color: AppColors.charcoalGrey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
