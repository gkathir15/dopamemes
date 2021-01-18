import 'dart:async';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:dopamemes/DopeTheme.dart';
import 'package:dopamemes/PostType.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/pages/VideoHorizontalScroller.dart';
import 'package:dopamemes/providers/AppSettingsProvider.dart';
import 'package:dopamemes/providers/FirebaseProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:dopamemes/exports/PagesExport.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:wiredash/wiredash.dart';

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
        ChangeNotifierProvider<FirebaseProvider>(
            create: (_) => FirebaseProvider()),
      ],
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with RouteAware {
  bool isReqSent = false;
  StreamSubscription _shareRecieveIntentSubScription;
  final _navigatorKey = GlobalKey<NavigatorState>();
  final RouteObserver<PageRoute> _routeObserver = RouteObserver<PageRoute>();

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      navigatorKey: _navigatorKey,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [_routeObserver],
        navigatorKey: _navigatorKey,
        title: "Dopamemes",
        darkTheme: kDarkTheme,
        themeMode: Provider.of<AppSettingProvider>(context).getTheme(),
        theme: kLightTheme,
        routes: {
          // '/': (context) => MainFeedList(),
          "fullVideo": (context) => VideoHorizontalScroller(),
          "settings": (context) => AppSettingsPage()
        },
        home: SplashScreen(useLoader: false,navigateAfterSeconds:MainFeedList() ,seconds: 3,imageBackground: AssetImage("assets/image/splash.jpg"),)
      ),
      projectId: "dopamemes-hnv70v6",
      secret: "2awlquvdc4c1ac60ottz6to5mvdbmmo1",
    );
  }



  @override
  void initState() {
    super.initState();
     const receiveIntent = const MethodChannel('receivedIntent');
     var receivedData = receiveIntent.invokeMapMethod("receivedIntent");
     if(receiveIntent!=null) {
       getReceivedData(receivedData);
     }
   // receiveIntent.setMethodCallHandler((call) => {});
     }


  Future<void> getReceivedData(Future<Map<dynamic,dynamic>> receivedData)
  async {
   var data = await receivedData;
    print("receivedData${data?.toString()}");
    //data = receivedData{path: https://youtu.be/eq3zolkk-DU, type: text/plain, fileType: text}
    if(data!=null)
      {

      }
    

  }

  @override
  void dispose() {
    _shareRecieveIntentSubScription.cancel();
    disposeBoxes();
    _routeObserver.unsubscribe(this);
    super.dispose();
  }



  @override
  void didChangeDependencies() {
    print("didChangeDep");
    // _routeObserver.subscribe(this,ModalRoute.of(context));
    if (!isReqSent) {
      isReqSent = true;
      //  Provider.of<AccountsProvider>(context).getCheckIfLoggedIn();


      Provider.of<PostProvider>(context).fetchPosts(Provider.of<AccountsProvider>(context,listen: false).getUserExtras().getUid());
      Provider.of<CategoriesProvider>(context).fetchCategories();
      Admob.initialize("ca-app-pub-6011809596899441~9949339806");
      // For sharing images coming from outside the app while the app is in the memory
    }
    super.didChangeDependencies();
  }

  // void navigateToNewPost(List<SharedMediaFile> value,BuildContext context) {
  //   var prototype = value.first.type == SharedMediaType.IMAGE
  //       ? PostType.IMAGE
  //       : PostType.VIDEO;
  //   Navigator.of(context).push(PageRouteBuilder(
  //       opaque: false,
  //       pageBuilder: (BuildContext context, _, __) =>
  //           NewPostDialog.withPath(prototype, value.first.path)));
  // }

  disposeBoxes() async {
    (await Hive.openBox<Categories>("CATEGORIES")).close();
    (await Hive.openBox<Posts>("POSTS")).close();
    (await Hive.openBox<DopeUser>("USER")).close();
    (await Hive.openBox<AppSettingsModel>("SETTING")).close();
  }

  @override
  void didPushNext() {
    
  }

  @override
  void didPop() {

  }

  @override
  void didPush() {

  }

  @override
  void didPopNext() {

  }
}
