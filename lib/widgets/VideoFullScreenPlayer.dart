import 'package:cached_video_player/cached_video_player.dart';
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
        return VisibilityDetector(
          key: ValueKey(url),
          child: Center(
            child: AspectRatio(
                child: CachedVideoPlayer(_cachedVideoPlayerController),
                aspectRatio:
                    value.aspectRatio!=null&& value.aspectRatio!= 0.0 ? value.aspectRatio : 16 / 9),
          ),
          onVisibilityChanged: (visibilityInfo) {
            double visiblePercentage = visibilityInfo.visibleFraction * 100;

            if (_cachedVideoPlayerController.value.isPlaying) {
              if (visiblePercentage < 90) _cachedVideoPlayerController.pause();
            } else {
              if (visiblePercentage > 90) _cachedVideoPlayerController.play();
            }
          },
        );
      },
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
  if (_cachedVideoPlayerController != null)  _cachedVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _cachedVideoPlayerController = CachedVideoPlayerController.network(url);
    _cachedVideoPlayerController.initialize().then((value) => {
          setState(() {
            _cachedVideoPlayerController.play();
            _cachedVideoPlayerController.setLooping(true);
            _cachedVideoPlayerController.setVolume(1.0);
          })
        });

    super.didChangeDependencies();
  }
}
