import 'package:dopamemes/VideoState.dart';
import 'package:dopamemes/VideoStateNotification.dart';
import 'package:dopamemes/providers/AppSettingsProvider.dart';
import 'package:ext_video_player/ext_video_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YTFullScreenWidget extends StatefulWidget {
  final String url;

  const YTFullScreenWidget({Key key, this.url}) : super(key: key);
  @override
  _YTFullScreenWidgetState createState() => _YTFullScreenWidgetState(url);
}

class _YTFullScreenWidgetState extends State<YTFullScreenWidget> with AutomaticKeepAliveClientMixin {
  final String url;
  VideoPlayerController _controller;
  YoutubePlayerController _webPlayerController;
  ValueNotifier<bool> nativePlayerError = ValueNotifier(false);

  _YTFullScreenWidgetState(this.url);
  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
        key: ValueKey(url),
        child: Center(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child:ValueListenableBuilder<bool>(builder: (_,value,__){
            return  value?YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    controller: _webPlayerController,
                  ),
                  builder: (context, player) {
                    return player;
                  }):VideoPlayer(_controller);

            },valueListenable: nativePlayerError,)

          ),
        ),
        onVisibilityChanged: (visibilityInfo) {
          double visiblePercentage = visibilityInfo.visibleFraction * 100;

          if (_controller.value.isPlaying) {
            if (visiblePercentage < 90)
              nativePlayerError.value?_webPlayerController.pause():_controller.pause();
          } else {
            if (visiblePercentage > 90)  nativePlayerError.value?_webPlayerController.play():_controller.play();
          }
        });
  }

  @override
  void dispose() {
    if (_controller != null) _controller.dispose();
    if(nativePlayerError.value)
      _webPlayerController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    print(url);
    _controller = VideoPlayerController.network(url);

    _controller.initialize();
    _controller.setLooping(false);


    _controller.addListener(() {
      if (_controller.value.hasError) {
        nativePlayerError.value = true;

        print("onError");

    _webPlayerController=    YoutubePlayerController(
            initialVideoId: YoutubePlayer.convertUrlToId(url),
            flags: YoutubePlayerFlags(
                hideControls: true,
                enableCaption: false,
                controlsVisibleAtStart: false,
                autoPlay: Provider.of<AppSettingProvider>(context).isAutolay(),
                disableDragSeek: true));
    _webPlayerController.addListener(() {
      if (_webPlayerController.value.hasError) {
       // print("onError");
        VideoStateNotification(VideoState.ON_ERROR)..dispatch(context);
      }
      if (_webPlayerController.value.playerState == PlayerState.ended) {
        VideoStateNotification(VideoState.FINISHED)..dispatch(context);
        return;
      }

    });


      }
      if (_controller.value.duration == _controller.value.position) {
        VideoStateNotification(VideoState.FINISHED)..dispatch(context);
        return;
      }

    });

    super.didChangeDependencies();
  }

  @override

  bool get wantKeepAlive => true;
}
