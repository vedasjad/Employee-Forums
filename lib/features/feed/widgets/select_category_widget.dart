import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/colors/colors.dart';
import '../providers/feed_provider.dart';

class SelectCategoryWidget extends StatelessWidget {
  const SelectCategoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Divider(
            height: 15,
            thickness: 4,
            color: AppColors.black,
            indent: screenWidth * 0.45,
            endIndent: screenWidth * 0.45,
          ),
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Select Category",
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 0.5,
            color: AppColors.black,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: context.watch<FeedProvider>().categories.length,
              itemBuilder: (context, index) {
                String selectedCategory =
                    context.watch<FeedProvider>().selectedCategory;
                String category =
                    context.watch<FeedProvider>().categories[index];
                return GestureDetector(
                  onTap: () {
                    context.read<FeedProvider>().updateCategory(category);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    color: selectedCategory == category
                        ? AppColors.coldWhite
                        : AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        context.watch<FeedProvider>().categories[index],
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
