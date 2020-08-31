import 'dart:io';

import 'package:dopamemes/pages/CategoriesFullScreenDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dopamemes/PostType.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:dopamemes/exports/PagesExport.dart';

class NewPostDialog extends StatefulWidget{

  PostType postType;
  String filePath;


  NewPostDialog(this.postType);

  NewPostDialog.withPath(this.postType, this.filePath);

  @override
  State<StatefulWidget> createState() {

   return postType == PostType.IMAGE||postType == PostType.VIDEO ? NewPostDialogState.withPath(postType,filePath) : NewPostDialogState(postType);

  }


}
class NewPostDialogState extends State<NewPostDialog> {

  PostType _postType;
  String _filePath;
 YoutubePlayerController _youtubePlayerController;
  Future<VideoPlayerController> _videoPlayerController;
  TextEditingController linkTextContorller;


  NewPostDialogState(this._postType);


  NewPostDialogState.withPath(this._postType, this._filePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: InkWell(child: Icon(Icons.close), onTap: () {
        Navigator.of(context).pop();
      },), title: Text("New Post"), centerTitle: true,), body: Container(
      child: ListView(children: [

        TextField(decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Title',
        )),
        TextField(decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Description',
        )),

        InkWell(child: Row(
          children: [
            Text("Category"),
            Row(children: [Text(Provider.of<CategoriesProvider>(context).newCategory.displayName),Icon(Icons.arrow_drop_down_circle)],),
          ],
        ),onTap: (){
          Navigator.of(context).push(PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) =>
                  CategoriesFullScreenDialog()));
        },
        )


      ],),
    ),);
  }


  @override
  void initState() {
    super.initState();
    if (_postType == PostType.VIDEO)
      {
        _videoPlayerController = VideoPlayerController.file(File(_filePath)).initialize();
      }else if(_postType == PostType.YOUTUBE){
   _youtubePlayerController=   YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId(_filePath));
    }else {
      linkTextContorller = TextEditingController();
    }


  }

  Widget fromPath(String path, PostType type) {
    if (type == PostType.IMAGE) {
      return Image.file(File(path));
    } else if (type == PostType.VIDEO) {
      return FutureBuilder(builder:(BuildContext context,AsyncSnapshot<VideoPlayerController> snapshot){
        if(snapshot.connectionState ==ConnectionState.done)
          {
            return AspectRatio(
              aspectRatio: snapshot.data.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(snapshot.data),
            );
          }else{
               return SizedBox(child: Center(child: CircularProgressIndicator(),widthFactor: MediaQuery.of(context).size.width,heightFactor:400),);
        }
      } ,future: _videoPlayerController,);
    }else if(type == PostType.YOUTUBE)
      {

            return YoutubePlayer(controller: _youtubePlayerController);

      }else {
      return TextField(decoration: InputDecoration(labelText: "Link or text"),controller: linkTextContorller,);
    }

  }













}