import 'package:admob_flutter/admob_flutter.dart';
import 'package:dopamemes/widgets/FullScreenCard.dart';
import 'package:flutter/material.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:dopamemes/exports/WidgetExports.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:provider/provider.dart';

class VideoHorizontalScroller extends StatefulWidget {
  @override
  _VideoHorizontalScrollerState createState() =>
      _VideoHorizontalScrollerState();
}

class _VideoHorizontalScrollerState extends State<VideoHorizontalScroller> {
  PageController _pageController;
  AdmobReward _admobReward;

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
                      return FullScreenCard(postWidget: YtPostWidget(_localList[index]),posts: _localList[index]);
                    } else if (_localList[index].postType == "video") {
                      return FullScreenCard(postWidget:VideoPostWidget(_localList[index]),posts: _localList[index]);
                    } else if (_localList[index].postType == "ad") {
                      _admobReward.load();
                      return Center(
                        child: CircularProgressIndicator(),
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
    _admobReward = AdmobReward(
        adUnitId: AdMobAdProvider.testBannerAd,
        listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          if (event == AdmobAdEvent.rewarded) {
            print('User was rewarded!');
            print('Reward type: ${args['type']}');
            print('Reward amount: ${args['amount']}');
          }
        });
    _pageController = PageController();

    super.initState();
  }

  @override
  void dispose() {
    _admobReward.dispose();
    _pageController.dispose();
    super.dispose();
  }

  onPageChanged(int index) {
    showAdIfLoaded(index);

    if (index == _localList.length - 1) {
      //print(snapshot.data[index].sId);
      if (Provider.of<PostProvider>(context, listen: false).lastId !=
          _localList.last.sId) {
        Provider.of<PostProvider>(context, listen: false)
            .paginatePosts(_localList.last);
      }
      Provider.of<PostProvider>(context, listen: false).lastId =
          _localList.last.sId;
    }
  }

  showAdIfLoaded(int lastLastValue) async {
    if (await _admobReward.isLoaded) _admobReward.load();
    {
      _admobReward.show();
     // _pageController.jumpToPage(lastLastValue+1);
    }
  }

  admobListener(AdmobAdEvent event, Map<String, dynamic> args) {
    if (event == AdmobAdEvent.rewarded) {
      print('User was rewarded!');
      print('Reward type: ${args['type']}');
      print('Reward amount: ${args['amount']}');
    }
  }
}
