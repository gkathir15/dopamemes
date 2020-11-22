import 'dart:io';
import 'package:video_player/video_player.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/jam_icons_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:dopamemes/exports/ProviderExports.dart';

class WebVideoPostWidget extends StatefulWidget {
  final Posts  _posts;

  WebVideoPostWidget(this._posts);

  @override
  State<StatefulWidget> createState() {
    return WebVideoPostWidgetState();
  }
}

class WebVideoPostWidgetState extends State<WebVideoPostWidget> with AutomaticKeepAliveClientMixin{


  VideoPlayerController _controller;
  ValueNotifier<bool> muteNotifier = ValueNotifier(false);
  AppSettingProvider settingsProvider ;

  @override
  Widget build(BuildContext context) {

    return VisibilityDetector(
      key: ValueKey(widget._posts.fileUrl),
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
                  child: VideoPlayer(_controller)),
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
                        value ? JamIcons.volume_up : JamIcons.volume_mute );
                  },
                  child: Icon(JamIcons.volume_mute),
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

    super.initState();
  }



  @override
  void didChangeDependencies() {
    settingsProvider = Provider.of<AppSettingProvider>(context);
    print(widget._posts.fileUrl);
    if (widget._posts.fileUrl.startsWith("https"))
      _controller = VideoPlayerController.network(widget._posts.fileUrl);
    else
      _controller = VideoPlayerController.file(File(widget._posts.fileUrl));

    // _controller.play();

    _controller.initialize().then((value) => {
      setState(() {
        if(settingsProvider.isAutolay())
          _controller.play();
        _controller.setLooping(true);
        _controller.setVolume(settingsProvider.isMute()?0.0:1.0);
      })
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) _controller.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({Key key, this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: ValueListenableBuilder(
        builder: (_, VideoPlayerValue value, Widget child) {
          return _isplayPauseBuffering(value);
        },
        child: _Buffering(),
        valueListenable: controller,
      ),
    );
  }

  Widget _isplayPauseBuffering(VideoPlayerValue value) {
    if (value.isBuffering) {
      return _Buffering();
    } else {
      if (value.isPlaying) {
        return Icon(
          JamIcons.pause,
          size: 30.0,
        );
      } else {
        return Icon(
          JamIcons.play,
          size: 30.0,
        );
      }
    }
  }
}

class _Buffering extends StatelessWidget {
  const _Buffering({
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