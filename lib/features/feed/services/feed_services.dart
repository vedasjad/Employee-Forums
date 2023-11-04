import 'dart:convert';

import 'package:employee_forums/models/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../common/utils/http_error_handle.dart';
import '../../../common/utils/snack_bar.dart';

class FeedServices {
  Future<List<Post>> getPostsPage(BuildContext context, int pageNumber) async {
    List<Post> newPost = [];
    final String url =
        'https://post-api-omega.vercel.app/api/posts?page=$pageNumber';
    try {
      http.Response res = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            newPost.add(
              Post.fromMap(
                jsonDecode(res.body)[i],
              ),
            );
          }
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      showSnackBar(context, e.toString());
    }
    return newPost;
  }
}
