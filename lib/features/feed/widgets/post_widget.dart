import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/colors/colors.dart';
import '../../../models/post.dart';
import '../providers/feed_provider.dart';
import 'more_options_widget.dart';
import 'options_widget.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final Post post = context.watch<FeedProvider>().posts[index];
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
                          Text(
                            post.eventLocation.type,
                            style: const TextStyle(
                              fontSize: 9,
                              color: AppColors.charcoalGrey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return MoreOptionsWidget(
                          index: index,
                          post: post,
                        );
                      },
                    );
                  },
                  child: const Icon(
                    Icons.more_horiz_rounded,
                    size: 20,
                  ),
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
          OptionsWidget(index: index, post: post),
        ],
      ),
    );
  }
}
