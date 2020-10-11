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
        future: Provider.of<PostProvider>(context).getFilteredList(Provider.of<CategoriesProvider>(context).mainCategory),
        builder:
            (BuildContext buildContext, AsyncSnapshot<List<Posts>> snapshot) {
          if (snapshot.hasData) {
            // var snapshot.data = snapshot.data;
            // if (Provider.of<CategoriesProvider>(context).mainCategory.sId !=
            //     "0") {
            //   snapshot.data = snapshot.data
            //       .where((element) =>
            //           element.categoryId ==
            //           Provider.of<CategoriesProvider>(context).mainCategory.sId)
            //       .toList();
            // }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == snapshot.data.length - 1) {
                    print(snapshot.data[index].sId);
                    if (Provider.of<PostProvider>(context, listen: false)
                            .lastId !=
                        snapshot.data.last.sId) {
                      Provider.of<PostProvider>(context, listen: false)
                          .paginatePosts(snapshot.data.last);
                    }
                    Provider.of<PostProvider>(context, listen: false).lastId=snapshot.data.last.sId;
                  }
                  if (snapshot.data[index].postType == "youtube") {
                    return PostsCard(
                        snapshot.data[index], YtPostWidget(snapshot.data[index].fileUrl));
                  } else if (snapshot.data[index].postType == "image") {
                    return PostsCard(
                        snapshot.data[index], ImagePostWidget(snapshot.data[index].fileUrl));
                  } else if (snapshot.data[index].postType == "video") {
                    return PostsCard(
                        snapshot.data[index], VideoPostWidget(snapshot.data[index].fileUrl));
                  } else if (snapshot.data[index].postType == "ad") {
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
