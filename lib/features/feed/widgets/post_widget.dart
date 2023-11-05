import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/colors/colors.dart';
import '../../../models/post.dart';
import '../providers/feed_provider.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    final Post post = context.watch<FeedProvider>().posts[widget.index];
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.grey.withOpacity(0.7),
            width: 7,
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        Icons.person,
                        size: 25,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "User ${post.userId}",
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          const Text(
                            "Location",
                            style: TextStyle(
                              fontSize: 9,
                              color: AppColors.charcoalGrey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.more_horiz_rounded,
                  size: 20,
                ),
              ],
            ),
          ),
          Image.network(
            post.image.first,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: screenWidth,
                width: screenWidth,
                color: AppColors.grey,
              );
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            alignment: Alignment.centerLeft,
            child: Text(
              post.description,
              maxLines: 2,
            ),
          ),
          Container(
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
                Row(
                  children: [
                    const Icon(
                      Icons.thumb_up_alt_outlined,
                      color: AppColors.charcoalGrey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "${post.likes} Likes",
                        style: const TextStyle(
                          color: AppColors.charcoalGrey,
                        ),
                      ),
                    ),
                  ],
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
                        "${post.noOfComments} Comments",
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
          ),
        ],
      ),
    );
  }
}
