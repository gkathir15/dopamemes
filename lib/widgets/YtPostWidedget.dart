import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as Yt;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YtPostWidget extends StatefulWidget {
  final Posts documents;

  YtPostWidget(this.documents);

  @override
  State<StatefulWidget> createState() {
    return YtPostWidgetState(documents);
  }
}

class YtPostWidgetState extends State<YtPostWidget> {
  Posts _documents;
  YtPostWidgetState(this._documents);
  YoutubePlayerController _controller;
  // ValueNotifier<bool> _isClicked = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey(_documents.sId),
      onVisibilityChanged: (visibilityInfo) {
        double visiblePercentage = visibilityInfo.visibleFraction * 100;

        if (_controller.value.isPlaying) {
          if (visiblePercentage < 90) _controller.pause();
        } else {
          if (visiblePercentage > 90) _controller.play();
        }
      },
      child: Center(
        child: AspectRatio(
          aspectRatio: 16/9,
                child: YoutubePlayer(
                  showVideoProgressIndicator: false,
                  bottomActions: [Yt.PlayPauseButton()],
              controller: _controller,
              thumbnail: CachedNetworkImage(
                  imageUrl: Yt.YoutubePlayer.getThumbnail(
                      videoId:
                          Yt.YoutubePlayer.convertUrlToId(_documents.fileUrl)))),
        ),
      ),
    );
  }

  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(_documents.fileUrl),
        flags: YoutubePlayerFlags(
      
            hideControls: true,
            enableCaption: false,
            controlsVisibleAtStart: false,
            autoPlay: true,
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
