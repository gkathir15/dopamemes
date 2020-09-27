import 'dart:io';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dopamemes/exports/ModelExports.dart';

class VideoPostWidget extends StatefulWidget
{
  Posts _documents;

  VideoPostWidget(this._documents);

  @override
  State<StatefulWidget> createState() {

    return  VideoPostWidgetState(_documents);
  }




}

class VideoPostWidgetState extends State<VideoPostWidget>{
  Posts _documents;
  VideoPostWidgetState(this._documents);
  CachedVideoPlayerController _controller;




  @override
  Widget build(BuildContext context) {

    return
      AspectRatio(key: UniqueKey(),
                  aspectRatio: _controller.value.aspectRatio>0.0?_controller.value.aspectRatio:1.8,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      CachedVideoPlayer(_controller),
                      _PlayPauseOverlay(controller: _controller),
                    ],
                  ));
            }


  @override
  void initState() {
    print(_documents.fileUrl);
    _controller = CachedVideoPlayerController.network(_documents.fileUrl);
   // _controller.play();

    _controller.initialize().then((value) => {setState(() {
    _controller.play();
    _controller.setVolume(0.0);
    })});
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
   if(_controller!=null)
    _controller.dispose();
  }
}


class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({Key key, this.controller}) : super(key: key);

  final CachedVideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return
          Stack(
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 50),
                reverseDuration: Duration(milliseconds: 200),
                child: controller.value.isPlaying
                    ? SizedBox.shrink()
                    : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 60.0,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.value.isPlaying ? controller.pause() : controller.play();
                },
              ),
            ],

          );
  }
}

// class _MuteUnmute extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//
//     return InkWell(child: Icon(Provider.of<VideoPlayerProvider>(context).isMute?Icons.volume_off:Icons.volume_up),onTap:(){ Provider.of<VideoPlayerProvider>(context).muteUnMute();});
//   }

