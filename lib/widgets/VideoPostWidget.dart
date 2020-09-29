import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPostWidget extends StatefulWidget {
  final Posts _documents;

  VideoPostWidget(this._documents);

  @override
  State<StatefulWidget> createState() {
    return VideoPostWidgetState(_documents);
  }
}

class VideoPostWidgetState extends State<VideoPostWidget> {
  Posts _documents;
  VideoPostWidgetState(this._documents);
  CachedVideoPlayerController _controller;
  ValueNotifier<bool> muteNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: UniqueKey(),
      onVisibilityChanged: (visibilityInfo) {
        double visiblePercentage = visibilityInfo.visibleFraction * 100;

        if (_controller.value.isPlaying) {
          if (visiblePercentage < 90) _controller.pause();
        } else {
          if (visiblePercentage > 90) _controller.play();
        }
      },
      child: Stack(
        children: [
          GestureDetector(
            child: AspectRatio(
                key: UniqueKey(),
                aspectRatio: _controller.value.aspectRatio > 0.0
                    ? _controller.value.aspectRatio
                    : 1.8,
                child: CachedVideoPlayer(_controller)),
            onTap: () {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            },
          ),
          Align(
            child: _PlayPauseOverlay(controller: _controller),
            alignment: Alignment.bottomRight,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 40,
              width: 40,
              child: GestureDetector(
                onTap: () {
                  muteNotifier.value = !muteNotifier.value;
                  if (muteNotifier.value)
                    _controller.setVolume(1.0);
                  else
                    _controller.setVolume(0.0);
                },
                child: ValueListenableBuilder(
                  builder: (_, bool value, child) {
                    return Icon(
                        value ? Icons.volume_up : Icons.volume_off_sharp);
                  },
                  child: Icon(Icons.volume_off_sharp),
                  valueListenable: muteNotifier,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    print(_documents.fileUrl);
    _controller = CachedVideoPlayerController.network(_documents.fileUrl);
    // _controller.play();

    _controller.initialize().then((value) => {
          setState(() {
            _controller.play();
            _controller.setLooping(true);
            _controller.setVolume(0.0);
          })
        });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _controller = CachedVideoPlayerController.network(_documents.fileUrl);
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) _controller.dispose();
  }
}

class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({Key key, this.controller}) : super(key: key);

  final CachedVideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: ValueListenableBuilder(
        builder: (_, CachedVideoPlayerValue value, Widget child) {
          return isplayPauseBuffering(value);
        },
        child: Buffering(),
        valueListenable: controller,
      ),
    );
  }

  Widget isplayPauseBuffering(CachedVideoPlayerValue value) {
    if (value.isBuffering) {
      return Buffering();
    } else {
      if (value.isPlaying) {
        return Center(
          child: Icon(
            Icons.pause,
            color: Colors.white,
            size: 30.0,
          ),
        );
      } else {
        return Center(
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 30.0,
          ),
        );
      }
    }
  }
}

class Buffering extends StatelessWidget {
  const Buffering({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ),
    );
  }
}
