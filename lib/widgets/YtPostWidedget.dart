import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dopamemes/exports/WidgetExports.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YtPostWidget extends StatefulWidget
{
  Posts documents;

  YtPostWidget(this.documents);

  @override
  State<StatefulWidget> createState() {

    return YtPostWidgetState(documents);
  }




}

class YtPostWidgetState extends State<YtPostWidget>{
  Posts documents;
  YtPostWidgetState(this.documents);
  YoutubePlayerController controller;




  @override
  Widget build(BuildContext context) {

    return
      YoutubePlayer(key:UniqueKey(),controller: controller);
  }

  @override
  void initState() {
    controller = YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId(documents.fileUrl),
    flags: YoutubePlayerFlags(controlsVisibleAtStart: true,autoPlay: false,disableDragSeek: true));
    super.initState();
  }



  @override
  void dispose() {
    super.dispose();
    controller.pause();
    controller.dispose();
  }
}