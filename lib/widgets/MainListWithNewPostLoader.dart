import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:dopamemes/exports/WidgetExports.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainListWithNewPostLoader extends StatelessWidget {
  const MainListWithNewPostLoader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ValueListenableBuilder<UploadStatus>(builder: (_context,bool,_){
            return bool == UploadStatus.UPLOADING?LinearProgressIndicator():Container(height: 0,);
          },
            valueListenable: Provider.of<NewPostProvider>(context).pollQueue(),),
          Expanded(child: PostsList()),
        ],
      ),
    );
  }
}