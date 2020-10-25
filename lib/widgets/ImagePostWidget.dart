import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dopamemes/widgets/NotSafePlaceHolder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ImagePostWidget extends StatelessWidget {
  final String _url;
  ImagePostWidget(this._url);
  ValueListenable<bool> _valueListenable = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _valueListenable,
      builder: (_, bool value, child) {
        if (value) {
          return CachedNetworkImage(
            imageUrl: _url,
            placeholder: (context, url) => Image.memory(kTransparentImage),
          );
        } else {
          return NotSafePlaceholder();
        }
      },
    );
  }
}
