import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dopamemes/exports/WidgetExports.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/exports/ProviderExports.dart';

class PostsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<PostProvider>(context).postsData,
        builder:
            (BuildContext buildContext, AsyncSnapshot<List<Posts>> snapshot) {
          if (snapshot.hasData) {
            var localList = snapshot.data;
            if (Provider.of<CategoriesProvider>(context).mainCategory.sId !=
                "0") {
              localList = snapshot.data
                  .where((element) =>
                      element.categoryDetails.sId ==
                      Provider.of<CategoriesProvider>(context).mainCategory.sId)
                  .toList();
            }
            return ListView.builder(
                itemCount: localList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == localList.length - 1) {
                    print(snapshot.data[index].sId);
                    if (Provider.of<PostProvider>(context, listen: false)
                            .lastId !=
                        snapshot.data.last.sId) {
                      Provider.of<PostProvider>(context, listen: false)
                          .paginatePosts(snapshot.data.last);
                    }
                    Provider.of<PostProvider>(context, listen: false).lastId =
                        snapshot.data.last.sId;
                  }
                  if (localList[index].postType == "youtube") {
                    return PostsCard(
                        localList[index], YtPostWidget(localList[index]));
                  } else if (localList[index].postType == "image") {
                    return PostsCard(
                        localList[index], ImagePostWidget(localList[index]));
                  } else if (localList[index].postType == "video") {
                    return PostsCard(
                        localList[index], VideoPostWidget(localList[index]));
                  } else if (localList[index].postType == "ad") {
                    return AdMobBannerAd();
                  } else {
                    return Container();
                  }
                });
          } else {
            print(snapshot.connectionState);
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
