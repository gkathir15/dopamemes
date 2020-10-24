import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YTFullScreenWidget extends StatefulWidget {
  final String url;

  const YTFullScreenWidget({Key key, this.url}) : super(key: key);
  @override
  _YTFullScreenWidgetState createState() => _YTFullScreenWidgetState(url);
}

class _YTFullScreenWidgetState extends State<YTFullScreenWidget> {
  final String url;
  YoutubePlayerController _controller;

  _YTFullScreenWidgetState(this.url);
  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
        key: ValueKey(url),
        child: Center(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: _controller,
                ),
                builder: (context, player) {
                  return player;
                }),
          ),
        ),
        onVisibilityChanged: (visibilityInfo) {
          double visiblePercentage = visibilityInfo.visibleFraction * 100;

          if (_controller.value.isPlaying) {
            if (visiblePercentage < 90) _controller.pause();
          } else {
            if (visiblePercentage > 90) _controller.play();
          }
        });
  }

  @override
  void dispose() {
   if (_controller != null) _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url),
        flags: YoutubePlayerFlags(
            hideControls: true,
            enableCaption: false,
            controlsVisibleAtStart: false,
            autoPlay: true,
            disableDragSeek: true));
    super.didChangeDependencies();
  }
}
