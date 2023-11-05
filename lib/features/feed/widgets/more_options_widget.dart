import 'package:flutter/material.dart';

import '../../../common/colors/colors.dart';

class MoreOptionsWidget extends StatefulWidget {
  const MoreOptionsWidget({
    super.key,
  });

  @override
  State<MoreOptionsWidget> createState() => _MoreOptionsWidgetState();
}

class _MoreOptionsWidgetState extends State<MoreOptionsWidget> {
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
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 2,
                        color: AppColors.black,
                      ),
                    ),
                    child: const Icon(
                      Icons.bookmark_border,
                      size: 35,
                    ),
                  ),
                  const Text(
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
