import 'dart:io';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:dopamemes/exports/ProviderExports.dart';

class VideoPostWidget extends StatefulWidget {
  final String _url;

  VideoPostWidget(this._url);

  @override
  State<StatefulWidget> createState() {
    return VideoPostWidgetState(_url);
  }
}

class VideoPostWidgetState extends State<VideoPostWidget> {
  String _Url;
  VideoPostWidgetState(this._Url);
  CachedVideoPlayerController _controller;
  ValueNotifier<bool> muteNotifier = ValueNotifier(false);
  AppSettingProvider settingsProvider ;

  @override
  Widget build(BuildContext context) {
    
    return VisibilityDetector(
      key: ValueKey(_Url),
      onVisibilityChanged: (visibilityInfo) {
        double visiblePercentage = visibilityInfo.visibleFraction * 100;

        if (_controller.value.isPlaying) {
          if (visiblePercentage < 90) _controller.pause();
        } else {
          if (visiblePercentage > 90) _controller.play();
        }
      },
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Align(
            child: GestureDetector(
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
          ),
          _PlayPauseOverlay(controller: _controller),
          Align(
            alignment: Alignment.bottomRight,
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
    settingsProvider = Provider.of<AppSettingProvider>(context);
    print(_Url);
    if (_Url.startsWith("https"))
      _controller = CachedVideoPlayerController.network(_Url);
    else
      _controller = CachedVideoPlayerController.file(File(_Url));

    // _controller.play();

    _controller.initialize().then((value) => {
          setState(() {
            if(settingsProvider.isAutolay())
            _controller.play();
            
            _controller.setLooping(true);

            
            _controller.setVolume(settingsProvider.isMute()?0.0:1.0);
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
        return Icon(
          Icons.pause,
          size: 30.0,
        );
      } else {
        return Icon(
          Icons.play_arrow,
          size: 30.0,
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
      ),
    );
  }
}
