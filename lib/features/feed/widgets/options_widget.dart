import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  });

  final Post post;

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
                context.read<FeedProvider>().togglePostLike(post, context),
            child: Row(
              children: [
                likedPosts.containsKey(post.userId + post.createdAt)
                    ? const Icon(
                        Icons.thumb_up_rounded,
                        color: AppColors.blue,
                        size: 20,
                      )
                    : const Icon(
                        Icons.thumb_up_alt_outlined,
                        color: AppColors.charcoalGrey,
                        size: 20,
                      ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "${likedPosts.containsKey(post.userId + post.createdAt) ? post.likes + 1 : post.likes} Likes",
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
              SvgPicture.asset(
                "assets/icons/comment.svg",
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
              SvgPicture.asset(
                "assets/icons/share.svg",
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
