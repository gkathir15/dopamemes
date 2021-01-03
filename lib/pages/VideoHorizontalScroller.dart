import 'package:dopamemes/VideoState.dart';
import 'package:dopamemes/VideoStateNotification.dart';
import 'package:dopamemes/widgets/FullScreenCard.dart';
import 'package:flutter/material.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:dopamemes/exports/WidgetExports.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:dopamemes/utils.dart';

class VideoHorizontalScroller extends StatefulWidget {
  @override
  _VideoHorizontalScrollerState createState() =>
      _VideoHorizontalScrollerState();
}

class _VideoHorizontalScrollerState extends State<VideoHorizontalScroller> {
  PageController _pageController;
  NativeAdmobController _nativeAdController;

  List<Posts> _localList;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ValueListenableBuilder(
        valueListenable: Provider.of<PostProvider>(context).postsHiveBox.listenable(),
        builder: (BuildContext context, Box<Posts> snapshot,Widget child) {
          _localList = snapshot.values
              .where((element) =>
          element.postType.toLowerCase() == "youtube" ||
              element.postType.toLowerCase() == "video" ||
              element.postType == "ad")
              .toList();
          return NotificationListener<VideoStateNotification>(
            onNotification: (VideoStateNotification value) {
              print("Listener ${value.videoState.toString()}");
              print("listened ${value.toString()}");
              if (value.videoState == VideoState.FINISHED ||
                  value.videoState == VideoState.ON_ERROR) {
                print("parent${value.videoState.toString()}");
                _pageController.nextPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.bounceIn);
              }
              return false;
            },
            child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _localList.length,
                onPageChanged: (value) => onPageChanged(value),
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  if (index ==  _localList.length - 1) {
                    print( snapshot.values.toList()[index].sId);
                    if (Provider
                        .of<PostProvider>(context, listen: false)
                        .lastId !=
                        snapshot.values.last.sId) {
                      Provider.of<PostProvider>(context, listen: false)
                          .paginatePosts();
                    }
                  }
                  if (_localList[index].postType == "youtube") {
                    return FullScreenCard(
                        postWidget: YTFullScreenWidget(
                            url: _localList[index].fileUrl),
                        posts: _localList[index]);
                  } else if (_localList[index].postType == "video") {
                    return FullScreenCard(
                        postWidget: VideoFullScreenPlayer(
                            url: _localList[index].fileUrl),
                        posts: _localList[index]);
                  } else if (_localList[index].postType == "ad") {
                    return NativeAdWidget(count: _localList
                        .where((element) => element.postType == "ad")
                        .length, nativeAdController: _nativeAdController);
                  } else {
                    return Container();
                  }
                }),
          );
        }),
    );
  }

  @override
  void initState() {
    _pageController = PageController();
    _nativeAdController = NativeAdmobController();
    setOrientationFullAuto();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nativeAdController.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    setOrientationPortrait();
    super.dispose();
  }

  onPageChanged(int index) {}
}


