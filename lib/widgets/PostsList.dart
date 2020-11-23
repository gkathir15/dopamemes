import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:dopamemes/exports/WidgetExports.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/exports/ProviderExports.dart';

class PostsList extends StatefulWidget {
  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  NativeAdmobController _nativeAdmobController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Provider.of<PostProvider>(context, listen: false)
            .postsHiveBox.listenable(),
        builder: (BuildContext ctx, Box<Posts> snap, Widget child) {
          var snapshot = List<Posts>();
          if(Provider.of<CategoriesProvider>(context).getFeedCategory().sId!="0")
            {
               snapshot = Provider.of<PostProvider>(context, listen: false)
                  .pumpAds(snap.values.where((element) => element.categoryId==Provider.of<CategoriesProvider>(context).getFeedCategory().sId).toList());
            }else{
             snapshot = Provider.of<PostProvider>(context, listen: false)
                .pumpAds(snap.values.toList());
          }
          if(snapshot.isNotEmpty) {
            return ListView.separated(
                addAutomaticKeepAlives: true,
                controller: Provider
                    .of<PostProvider>(context)
                    .scrollController,
                separatorBuilder: (context, index) =>
                    Divider(
                      height: 2,
                      thickness: 1,
                    ),
                itemCount: snapshot.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == snapshot.length - 1) {
                    print(snapshot[index].sId);
                    if (Provider
                        .of<PostProvider>(context, listen: false)
                        .lastId !=
                        snapshot.last.sId) {
                      Provider.of<PostProvider>(context, listen: false)
                          .paginatePosts();
                    }
                    Provider
                        .of<PostProvider>(context, listen: false)
                        .lastId =
                        snapshot.last.sId;
                  }
                  if (snapshot[index].postType == "ad") {
                    return AdMobBannerAd();
                  }
                  return PostsCard(snapshot[index]);
                });
          }else{
           return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        child: Center(
          child: CircularProgressIndicator(),
        ));
  }

  @override
  void initState() {
    _nativeAdmobController = NativeAdmobController();
    super.initState();
  }

  @override
  void dispose() {
    _nativeAdmobController.dispose();
    super.dispose();
  }
}
