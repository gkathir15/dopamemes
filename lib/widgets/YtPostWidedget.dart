import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as Yt;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YtPostWidget extends StatefulWidget {
  final String _url;

  YtPostWidget(this._url);

  @override
  State<StatefulWidget> createState() {
    return YtPostWidgetState(_url);
  }
}

class YtPostWidgetState extends State<YtPostWidget> {
  String _url;
  YtPostWidgetState(this._url);
  YoutubePlayerController _controller;
  // ValueNotifier<bool> _isClicked = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey(_url),
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
                fit: BoxFit.fitWidth,
                    imageUrl: Yt.YoutubePlayer.getThumbnail(
                        videoId:
                            Yt.YoutubePlayer.convertUrlToId(_url)))),
        ),
      ),
    );
  }

  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(_url),
        flags: YoutubePlayerFlags(
      
            hideControls: true,
            enableCaption: false,
            controlsVisibleAtStart: false,
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
