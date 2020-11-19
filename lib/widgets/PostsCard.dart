import 'dart:ui';

import 'package:dopamemes/exports/WidgetExports.dart';
import 'package:dopamemes/jam_icons_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/TimeFormat.dart' as timeAgo;
import 'package:share/share.dart';

class PostsCard extends StatefulWidget {
  final Posts _document;
  //final Widget _widget;

  PostsCard(this._document);

  @override
  State<StatefulWidget> createState() {
    return PostsCardState(_document);
  }
}

class PostsCardState extends State<PostsCard> {
  Posts _document;

  var cardRadius =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0));

  PostsCardState(this._document);
  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isLiked = ValueNotifier(_document.is_liked!=null?_document.is_liked:false);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Text(
                _document.caption,
                style: GoogleFonts.roboto(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 2.0, bottom: 4.0),
                      child: Text(_document.categoryDetails.displayName,
                          style: GoogleFonts.roboto()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(

                        timeAgo.formatTime(_document.createdAt),

                        style: GoogleFonts.roboto(),
                        textScaleFactor: 0.6,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ClipRRect(child: contextWidget(_document),borderRadius: BorderRadius.circular(8.0),),
      //The content widget..
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        isLiked.value = !isLiked.value;
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ValueListenableBuilder<bool>(
                          builder: (_,bool,__){
                            return bool?Icon(
                              JamIcons.heart_f,
                              color: Colors.redAccent,
                              size: 30,
                            ):Icon(
                              JamIcons.heart,
                              size: 30,
                            );
                          },
                          valueListenable:isLiked ,
                        ),
                      ),
                    ),
                    Text("${_document.likes_count} likes")
                  ],

                ),
                Column(
                  children: [
                    InkWell(
                      onTap: (){
                      Share.share("Check out this post form Dopamemes www.Dopamemes.live/${_document.sId}",subject: "Share Via");
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top:10,left: 10,right:10),
                        child: Icon(
                          JamIcons.share,
                          size: 30,
                        ),
                      ),
                    ),
                    Text("Share",style: GoogleFonts.roboto(),)
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget contextWidget(Posts _document)
  {
    if (_document.postType == "youtube") {
      return  YTFullScreenWidget(url:_document.fileUrl);
    } else if (_document.postType == "image") {
      return ImagePostWidget(_document);
    } else if (_document.postType == "video") {
      return
        kIsWeb?WebVideoPostWidget(_document):VideoPostWidget(_document);
    } else if (_document.postType == "ad") {
      return AdMobBannerAd();
    } else if (_document.postType == "vidList") {

      return Container();
        //HorizontalVideoIntruder(postsList:snapshot.data.where((element) => element.postType=="video").toList() );
    } else {
      return Container();
    }
  }
}
