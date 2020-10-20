import 'dart:async';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:dopamemes/DopeTheme.dart';
import 'package:dopamemes/PostType.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/pages/VideoHorizontalScroller.dart';
import 'package:dopamemes/providers/AppSettingsProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:dopamemes/exports/PagesExport.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PostsAdapter());
  Hive.registerAdapter(CategoriesAdapter());
  Hive.registerAdapter(CategoryDetailsAdapter());
  Hive.registerAdapter(OwnerDetailsAdapter());
  Hive.registerAdapter(DopeUserAdapter());
  Hive.registerAdapter(AppSettingsModelAdapter());

  await Hive.openBox<Categories>("CATEGORIES");
  await Hive.openBox<Posts>("POSTS");
  await Hive.openBox<DopeUser>("USER");
  await Hive.openBox<AppSettingsModel>("SETTING");

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
        ChangeNotifierProvider<AppSettingProvider>(
            create: (_) => AppSettingProvider()),
      ],
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isReqSent = false;
  StreamSubscription _shareRecieveIntentSubScription;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dopamemes",
      darkTheme: kDarkTheme,
      themeMode:  Provider.of<AppSettingProvider>(context).getTheme(),
      theme: kLightTheme,
      routes: {
        // '/': (context) => MainFeedList(),
        "fullVideo": (context) => VideoHorizontalScroller(),
        "settings": (context) => AppSettingsPage()
      },
      home: MainFeedList(),
    );
  }

  @override
  void initState() {
    super.initState();

    // For sharing images coming from outside the app while the app is in the memory
    _shareRecieveIntentSubScription = ReceiveSharingIntent.getMediaStream()
        .listen((List<SharedMediaFile> value) {
      print("share" + value.first.path);
      navigateToNewPost(value);
    }, onError: (err) {
      print("getIntentDataStream error: $err");
    });

    // For sharing images coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
      print("share" + value.first.path);
      navigateToNewPost(value);
    });

    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    _shareRecieveIntentSubScription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      print("share" + value);
    }, onError: (err) {
      print("getLinkStream error: $err");
    });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String value) {
      print("share" + value);
    });
  }

  @override
  void dispose() {
    _shareRecieveIntentSubScription.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    print("didChangeDep");
    if (!isReqSent) {
      isReqSent = true;
      //  Provider.of<AccountsProvider>(context).getCheckIfLoggedIn();
      Firebase.initializeApp();

      Provider.of<PostProvider>(context).fetchPosts();
      Provider.of<CategoriesProvider>(context).fetchCategories();
      Provider.of<AccountsProvider>(context).loggedResponse();
      Admob.initialize("ca-app-pub-6011809596899441~9949339806");
    }
    super.didChangeDependencies();
  }

  void navigateToNewPost(List<SharedMediaFile> value) {
    var posttype = value.first.type == SharedMediaType.IMAGE
        ? PostType.IMAGE
        : PostType.VIDEO;
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) =>
            NewPostDialog.withPath(posttype, value.first.path)));
  }
}
