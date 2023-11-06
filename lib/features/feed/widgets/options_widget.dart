import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../common/colors/colors.dart';
import '../../../common/hive/hive_boxes.dart';
import '../../../models/post.dart';
import '../providers/feed_provider.dart';

class OptionsWidget extends StatefulWidget {
  const OptionsWidget({
    super.key,
    required this.post,
    required this.index,
  });

  final Post post;
  final int index;

  @override
  State<OptionsWidget> createState() => _OptionsWidgetState();
}

class _OptionsWidgetState extends State<OptionsWidget> {
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
            onTap: () => context
                .read<FeedProvider>()
                .togglePostLike(widget.index, widget.post),
            child: Row(
              children: [
                likedPosts.containsKey(widget.index)
                    ? const Icon(
                        Icons.thumb_up_rounded,
                        color: AppColors.blue,
                      )
                    : const Icon(
                        Icons.thumb_up_alt_outlined,
                        color: AppColors.charcoalGrey,
                      ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "${likedPosts.containsKey(widget.index) ? widget.post.likes + 1 : widget.post.likes} Likes",
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
              const Icon(
                Icons.comment_outlined,
                color: AppColors.charcoalGrey,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "${widget.post.noOfComments} Comments",
                  style: const TextStyle(
                    color: AppColors.charcoalGrey,
                  ),
                ),
              ),
            ],
          ),
          const Row(
            children: [
              Icon(
                Icons.share,
                color: AppColors.charcoalGrey,
              ),
              Padding(
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
