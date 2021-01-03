
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:dopamemes/widgets/NotSafePlaceHolder.dart';
import 'package:dopamemes/widgets/WaveloadingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImagePostWidget extends StatefulWidget {
  final Posts _posts;
  ImagePostWidget(this._posts);

  @override
  _ImagePostWidgetState createState() => _ImagePostWidgetState();
}

class _ImagePostWidgetState extends State<ImagePostWidget> with AutomaticKeepAliveClientMixin {
  ValueNotifier<bool> _valueListenable;

  @override
  Widget build(BuildContext context) {
    var showNsfwOverLay =
        Provider.of<AppSettingProvider>(context).isShowNfswOverLay();

    _valueListenable =
        ValueNotifier(!(widget._posts.checkIfMature() && showNsfwOverLay));

    return ValueListenableBuilder(
      valueListenable: _valueListenable,
      builder: (_, bool value, child) {
        if (value) {
          return CachedNetworkImage(
            progressIndicatorBuilder: (_, __, ___) {
              return WaveloadingWidget();
            },
            imageUrl: widget._posts.fileUrl,
            // placeholder: (context, url) => Image.memory(kTransparentImage),
          );
        } else {
          return InkWell(
            child: NotSafePlaceholder(),
            onTap: () {
              _valueListenable.value = true;
              widget._posts.isMature = "false";
            },
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
