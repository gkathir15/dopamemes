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
        future: Provider.of<PostProvider>(context).getFilteredList(
            Provider.of<CategoriesProvider>(context,listen:true).mainCategory),
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
            return ListView.separated(
              addAutomaticKeepAlives: true,
              controller: Provider.of<PostProvider>(context,listen: false).scrollController,
                separatorBuilder: (context, index) => Divider(
                      height: 2,
                      thickness: 1,
                    
                    ),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == snapshot.data.length - 1) {
                    print(snapshot.data[index].sId);
                    if (Provider.of<PostProvider>(context, listen: false)
                            .lastId !=
                        snapshot.data.last.sId) {
                      Provider.of<PostProvider>(context, listen: false)
                          .paginatePosts();
                    }
                    Provider.of<
                        PostProvider>(context, listen: false).lastId =
                        snapshot.data.last.sId;
                  }
                    return PostsCard(snapshot.data[index]);
                });
          } else {
            print(snapshot.connectionState);
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
