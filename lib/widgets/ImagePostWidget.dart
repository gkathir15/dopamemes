import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ImagePostWidget extends StatelessWidget{
 final  String _url;
  ImagePostWidget(this._url);
@override
  Widget build(BuildContext context) {

    return
      CachedNetworkImage(imageUrl: _url,placeholder: (context, url) => Image.memory(kTransparentImage),);
  }
}