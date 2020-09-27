import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dopamemes/exports/PagesExport.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:dopamemes/exports/WidgetExports.dart';


void main() {
  runApp(
    MultiProvider(
      child: MyApp(),
      providers: [
        ChangeNotifierProvider<PostProvider>(create: (_) => PostProvider()),
        ChangeNotifierProvider<AccountsProvider>(create: (_) => AccountsProvider()),
        ChangeNotifierProvider<VideoCacheProvider>(create: (_)=>VideoCacheProvider()),
        ChangeNotifierProvider<CategoriesProvider>(create: (_)=>CategoriesProvider()),
        ChangeNotifierProvider<NewPostProvider>(create: (_)=>NewPostProvider()),
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Dopamemes",
        showPerformanceOverlay: false,
        darkTheme: ThemeData.dark(),
      routes: {'/': (context) => MainFeedList(),
                "login":(context) => GooleSigninPage(),
      },);
  }
}


