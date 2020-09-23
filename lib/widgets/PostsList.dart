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
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == snapshot.data.length-1) {
                    print(snapshot.data[index].sId);
                    Provider.of<PostProvider>(context, listen: false)
                        .paginatePosts(snapshot.data[index-1]);
                  }
                  if (snapshot.data[index].postType == "youtube") {
                    return PostsCard(snapshot.data[index],
                        YtPostWidget(snapshot.data[index]));
                  } else if (snapshot.data[index].postType == "image") {
                    return PostsCard(snapshot.data[index],
                        ImagePostWidget(snapshot.data[index]));
                  } else if (snapshot.data[index].postType == "video") {
                    return PostsCard(snapshot.data[index],
                        VideoPostWidget(snapshot.data[index]));
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
