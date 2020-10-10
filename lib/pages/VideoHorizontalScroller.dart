import 'package:admob_flutter/admob_flutter.dart';
import 'package:dopamemes/widgets/FullScreenCard.dart';
import 'package:flutter/material.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:dopamemes/exports/WidgetExports.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:provider/provider.dart';

class VideoHorizontalScroller extends StatefulWidget {
  @override
  _VideoHorizontalScrollerState createState() =>
      _VideoHorizontalScrollerState();
}

class _VideoHorizontalScrollerState extends State<VideoHorizontalScroller> {
  PageController _pageController;
  final _nativeAdController = NativeAdmobController();

  List<Posts> _localList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<List<Posts>> snapshot) {
            if (snapshot.hasData) {
              _localList = snapshot.data
                  .where((element) =>
                      element.postType.toLowerCase() == "youtube" ||
                      element.postType.toLowerCase() == "video" ||
                      element.postType == "ad")
                  .toList();
              return PageView.builder(
                  itemCount: _localList.length,
                  onPageChanged: (value) => onPageChanged(value),
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    if (_localList[index].postType == "youtube") {
                      return FullScreenCard(
                          postWidget: YtPostWidget(_localList[index].fileUrl),
                          posts: _localList[index]);
                    } else if (_localList[index].postType == "video") {
                      return FullScreenCard(
                          postWidget:
                              VideoPostWidget(_localList[index].fileUrl),
                          posts: _localList[index]);
                    } else if (_localList[index].postType == "ad") {
                      return NativeAdmob(
                        loading: Center(child: CircularProgressIndicator()),
                        error: Text("Failed to load the ad"),
                        adUnitID: AdMobAdProvider.nativeAdvancedVideo,
                        controller: _nativeAdController,
                        type: NativeAdmobType.full,
                        options: NativeAdmobOptions(
                          ratingColor: Colors.red,
                        ),
                      );
                    } else {
                      return Container();
                    }
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          future: Provider.of<PostProvider>(context).postsData,
        ),
      ),
    );
  }

  @override
  void initState() {
    _pageController = PageController();

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  onPageChanged(int index) {}
}
