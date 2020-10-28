import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:dopamemes/widgets/NotSafePlaceHolder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ImagePostWidget extends StatelessWidget {
  final Posts _posts;
  ImagePostWidget(this._posts);
  ValueNotifier<bool> _valueListenable;
  @override
  Widget build(BuildContext context) {
    var showNsfwOverLay =
        Provider.of<AppSettingProvider>(context).isShowNfswOverLay();

    _valueListenable =
        ValueNotifier(!(!_posts.chekcIfMature() && !showNsfwOverLay));

    return ValueListenableBuilder(
      valueListenable: _valueListenable,
      builder: (_, bool value, child) {
        if (value) {
          return CachedNetworkImage(
            imageUrl: _posts.fileUrl,
            placeholder: (context, url) => Image.memory(kTransparentImage),
          );
        } else {
          return InkWell(
            child: NotSafePlaceholder(),
            onTap: () {
              _valueListenable.value = true;
            },
          );
        }
      },
    );
  }
}
