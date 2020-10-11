import 'package:dopamemes/pages/VideoHorizontalScroller.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:dopamemes/exports/PagesExport.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
Hive.initFlutter();
  runApp(
    MultiProvider(
      child: MyApp(),
      providers: [
        ChangeNotifierProvider<PostProvider>(create: (_) => PostProvider()),
        ChangeNotifierProvider<AccountsProvider>(
            create: (_) => AccountsProvider()),
        ChangeNotifierProvider<VideoCacheProvider>(
            create: (_) => VideoCacheProvider()),
        ChangeNotifierProvider<CategoriesProvider>(
            create: (_) => CategoriesProvider()),
        ChangeNotifierProvider<NewPostProvider>(
            create: (_) => NewPostProvider()),
      ],
    ),
  );
}

// runApp(
//   MultiProvider(
//     child: MyApp(),
//     providers: [
//       ChangeNotifierProvider<PostProvider>(create: (_) => PostProvider()),
//       ChangeNotifierProvider<AccountsProvider>(
//           create: (_) => AccountsProvider()),
//       ChangeNotifierProvider<VideoCacheProvider>(
//           create: (_) => VideoCacheProvider()),
//       ProxyProvider<PostProvider, NewPostProvider>(
//         update: (BuildContext cont, PostProvider postsProvider,
//                 NewPostProvider newPostProvider) =>
//             NewPostProvider(postsProvider),
//       ),
//       ProxyProvider2<PostProvider, NewPostProvider, CategoriesProvider>(
//           update: (BuildContext cont,
//                   PostProvider postsProvider,
//                   NewPostProvider newPostsProv,
//                   CategoriesProvider categoriesProvider) =>
//               CategoriesProvider(postsProvider, newPostsProv)),
//     ],
//   ),
// );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dopamemes",
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      theme: ThemeData(),
      routes: {
        '/': (context) => MainFeedList(),
        "fullVideo": (context) => VideoHorizontalScroller(),
        "settings": (context) => AppSettingsPage()
      },
    );
  }
}
