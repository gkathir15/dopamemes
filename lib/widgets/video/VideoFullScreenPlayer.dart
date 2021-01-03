import 'package:cached_video_player/cached_video_player.dart';
import 'package:dopamemes/VideoState.dart';
import 'package:dopamemes/VideoStateNotification.dart';
import 'package:dopamemes/widgets/CenterLoading.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoFullScreenPlayer extends StatefulWidget {
  final url;

  const VideoFullScreenPlayer({Key key, this.url}) : super(key: key);
  @override
  _VideoFullScreenPlayerState createState() => _VideoFullScreenPlayerState(url);
}

class _VideoFullScreenPlayerState extends State<VideoFullScreenPlayer> {
  final url;
  CachedVideoPlayerController _cachedVideoPlayerController;

  _VideoFullScreenPlayerState(this.url);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _cachedVideoPlayerController,
      builder: (_, CachedVideoPlayerValue value, Widget child) {
        // if (value.hasError) {
        //   print("onError");
        //   VideoStateNotification(VideoState.ON_ERROR)..dispatch(context);
        //   return CenterLoading();
        // }
        // if (value.duration == value.position) {
        //   print("onFinish ${value.position } of ${ value.duration}");
        //   VideoStateNotification(VideoState.FINISHED)..dispatch(context);
        // }
        if (value.initialized) {
          _cachedVideoPlayerController.play();
          _cachedVideoPlayerController.setLooping(false);
          _cachedVideoPlayerController.setVolume(1.0);
          return VisibilityDetector(
            key: ValueKey(url),
            child: Center(
              child: AspectRatio(
                  child: CachedVideoPlayer(_cachedVideoPlayerController),
                  aspectRatio:
                      value.aspectRatio != null && value.aspectRatio > 0.0
                          ? value.aspectRatio
                          : 1.8),
            ),
            onVisibilityChanged: (visibilityInfo) {
              double visiblePercentage = visibilityInfo.visibleFraction * 100;

              if (_cachedVideoPlayerController.value.isPlaying) {
                if (visiblePercentage < 80)
                  _cachedVideoPlayerController.pause();
              } else {
                if (visiblePercentage > 80) _cachedVideoPlayerController.play();
              }
            },
          );
        } else {
          return CenterLoading();
        }
      },
      child: CenterLoading(),
    );
  }

  @override
  void dispose() {
    if (_cachedVideoPlayerController != null)
      _cachedVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _cachedVideoPlayerController = CachedVideoPlayerController.network(url);
    _cachedVideoPlayerController.initialize();
    _cachedVideoPlayerController.addListener(() {
           if (_cachedVideoPlayerController.value.hasError) {
          print("onError");
          VideoStateNotification(VideoState.ON_ERROR)..dispatch(context);
          return CenterLoading();
        }
        if (_cachedVideoPlayerController.value.duration == _cachedVideoPlayerController.value.position) {
          print("onFinish ${_cachedVideoPlayerController.value.position } of ${ _cachedVideoPlayerController.value.duration}");
         
          VideoStateNotification(VideoState.FINISHED)..dispatch(context);
        }
    });

    super.didChangeDependencies();
  }
}
