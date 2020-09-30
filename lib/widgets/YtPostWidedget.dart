import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as Yt;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YtPostWidget extends StatefulWidget {
  Posts documents;

  YtPostWidget(this.documents);

  @override
  State<StatefulWidget> createState() {
    return YtPostWidgetState(documents);
  }
}

class YtPostWidgetState extends State<YtPostWidget> {
  Posts documents;
  YtPostWidgetState(this.documents);
  YoutubePlayerController _controller;
  ValueNotifier<bool> _isClicked = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        builder: (_, bool value, Widget child) {
          return !value
              ? AspectRatio(
                  aspectRatio: (16 / 9),
                  child: Stack(
                    children: [
                      Align(
                        child: CachedNetworkImage(
                            imageUrl: Yt.YoutubePlayer.getThumbnail(
                                videoId: Yt.YoutubePlayer.convertUrlToId(
                                    documents.fileUrl)),
                            errorWidget: (_, __, ___) =>
                                YoutubePlayer(controller: _controller)),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          child: Icon(
                            LineAwesomeIcons.play,
                            size: 50,
                          ),
                          onTap: () {
                            _isClicked.value = true;
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : YoutubePlayer(controller: _controller);
        },
        valueListenable: _isClicked,
        child: AspectRatio(
          aspectRatio: (16 / 9),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }

  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(documents.fileUrl),
        flags: YoutubePlayerFlags(
            controlsVisibleAtStart: true,
            autoPlay: false,
            disableDragSeek: true));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.pause();
    _controller.dispose();
  }
}
