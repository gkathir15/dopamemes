import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as Yt;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YtPostWidget extends StatefulWidget {
final Posts _posts;

  YtPostWidget(this._posts);

  @override
  State<StatefulWidget> createState() {
    return YtPostWidgetState();
  }
}

class YtPostWidgetState extends State<YtPostWidget> {
  
  YoutubePlayerController _controller;
  // ValueNotifier<bool> _isClicked = ValueNotifier(false);
  AppSettingProvider settingsProvider;


  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey(widget._posts.fileUrl),
      onVisibilityChanged: (visibilityInfo) {
        double visiblePercentage = visibilityInfo.visibleFraction * 100;

        if (_controller.value.isPlaying) {
          if (visiblePercentage < 90) _controller.pause();
        } else {
          if (visiblePercentage > 100) _controller.play();
        }
      },
      child: Center(
        child: GestureDetector(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: YoutubePlayer(
                showVideoProgressIndicator: false,
                bottomActions: [Yt.PlayPauseButton()],
                controller: _controller,
                thumbnail: CachedNetworkImage(
                    fit: BoxFit.fitWidth,
                    imageUrl: Yt.YoutubePlayer.getThumbnail(
                        videoId: Yt.YoutubePlayer.convertUrlToId(widget._posts.fileUrl)))),
          ),
          onTap: () {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.pause();
    _controller.dispose();
  }

  @override
  void didChangeDependencies() {
   settingsProvider = Provider.of<AppSettingProvider>(context);
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget._posts.fileUrl),
        flags: YoutubePlayerFlags(
            hideControls: true,
            enableCaption: false,
            controlsVisibleAtStart: false,
            autoPlay: settingsProvider.isAutolay(),
            disableDragSeek: true)
            );
    settingsProvider.isMute() ? _controller.mute() : _controller.unMute();
    super.didChangeDependencies();
  }
}
