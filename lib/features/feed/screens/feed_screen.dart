import 'package:flutter/material.dart';

import '../../../common/colors/colors.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Expanded(
                  child: SearchBar(
                    leading: Icon(
                      Icons.search,
                      color: AppColors.greyTextColor,
                    ),
                    hintText: "Search Messages",
                  ),
                ),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                    child: Image.asset(
                      "assets/icons/filter.png",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.4,
            color: AppColors.white,
            child: const Column(
              children: [],
            ),
          )
        ],
      ),
    );
  }
}
