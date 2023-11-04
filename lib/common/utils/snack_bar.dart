import 'package:flutter/material.dart';

import '../colors/colors.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.black,
      content: Text(
        text,
        style: const TextStyle(
          color: AppColors.white,
        ),
      ),
    ),
  );
}
