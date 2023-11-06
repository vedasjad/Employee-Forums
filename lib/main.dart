import 'package:employee_forums/common/hive/hive_boxes.dart';
import 'package:employee_forums/common/themes/themes.dart';
import 'package:employee_forums/features/feed/providers/feed_provider.dart';
import 'package:employee_forums/features/home/providers/home_provider.dart';
import 'package:employee_forums/models/event_location.dart';
import 'package:employee_forums/models/post.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'features/home/screens/home_screen.dart';
import 'models/comment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PostAdapter());
  Hive.registerAdapter(EventLocationAdapter());
  Hive.registerAdapter(CommentAdapter());
  await Hive.openBox(HiveBoxes.likedPosts);
  await Hive.openBox(HiveBoxes.savedPosts);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => FeedProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.light,
        home: HomeScreen(),
      ),
    );
  }
}
