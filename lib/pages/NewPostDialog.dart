import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:dio/dio.dart';
import 'package:dopamemes/pages/CategoriesFullScreenDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dopamemes/PostType.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:dopamemes/exports/PagesExport.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as Yt;

class NewPostDialog extends StatefulWidget {
  PostType postType;
  String filePath;

  NewPostDialog(this.postType);

  NewPostDialog.withPath(this.postType, this.filePath);

  @override
  State<StatefulWidget> createState() {
    return postType == PostType.IMAGE || postType == PostType.VIDEO
        ? NewPostDialogState.withPath(postType, filePath)
        : NewPostDialogState(postType);
  }
}

class NewPostDialogState extends State<NewPostDialog> {
  PostType _postType;
  String _filePath;
// YoutubePlayerController _youtubePlayerController;
  CachedVideoPlayerController _videoPlayerController;
  TextEditingController titleTextController;
  TextEditingController despController;
  TextEditingController linkTextController;

  NewPostDialogState(this._postType);

  NewPostDialogState.withPath(this._postType, this._filePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.close),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("New Post"),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: [
            fromPath(_filePath, _postType),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: titleTextController,
              ),
            ),
            LinkWidget(linkTextController, _postType),
            InkWell(
              child: Column(
                children: [
                  Text("Category"),
                  Row(
                    children: [
                      Text(Provider.of<CategoriesProvider>(context,
                              listen: false)
                          .newPostUploadCategory
                          .displayName),
                      Icon(Icons.arrow_drop_down_circle)
                    ],
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) =>
                        CategoriesFullScreenDialog()));
              },
            ),
            RaisedButton(
              onPressed: () {
                if (_postType == PostType.YOUTUBE) {
                  youtubeUpload();
                } else if (_postType == PostType.IMAGE ||
                    _postType == PostType.VIDEO) {
                  fileUploadUpload();
                }

                Navigator.of(context).pop();
              },
              child: Text("Continue"),
            )
          ],
        ),
      ),
    );
  }

  youtubeUpload() {
    var map = Map<String, String>();
    map["caption"] = titleTextController.text;
    map["ownerId"] = "5f4bf11b4eece7b043c8cc29";
    map["categoryId"] = Provider.of<CategoriesProvider>(context, listen: false)
        .newPostUploadCategory
        .sId;
    map["youtubeUrl"] = _filePath;
    Provider.of<NewPostProvider>(context, listen: false).newYoutubePost(map);
  }

  fileUploadUpload() async {
    FormData formData;
    var map = Map<String, dynamic>();
    map["caption"] = titleTextController.text;
    map["ownerId"] = "5f4bf11b4eece7b043c8cc29";
    map["categoryId"] = Provider.of<CategoriesProvider>(context, listen: false)
        .newPostUploadCategory
        .sId;
    map["file"] = await MultipartFile.fromFile(_filePath);
    map["postType"] = _postType
        .toString()
        .split(".")[1]
        .toLowerCase(); //splitting from PostType.IMAGE to image
    formData = FormData.fromMap(map);
    Provider.of<NewPostProvider>(context, listen: false)
        .newFilePostUpload(formData);
  }

  @override
  void initState() {
    super.initState();
    titleTextController = TextEditingController();
    linkTextController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    titleTextController?.dispose();
    despController?.dispose();
    linkTextController?.dispose();
    //  _youtubePlayerController?.dispose();
  }

  Widget fromPath(String path, PostType type) {
    if (_filePath != null) {
      if (type == PostType.IMAGE) {
        return Image.file(File(path));
      } else if (type == PostType.VIDEO) {
        _videoPlayerController =
            CachedVideoPlayerController.file(File(_filePath));
        _videoPlayerController.initialize();
        var size = MediaQuery.of(context).size;
        return SizedBox(
          child: CachedVideoPlayer(_videoPlayerController),
          width: size.width,
          height: size.height / 3,
        );
      } else if (type == PostType.YOUTUBE && path != null) {
        return CachedNetworkImage(
            imageUrl: Yt.YoutubePlayer.getThumbnail(
                videoId: Yt.YoutubePlayer.convertUrlToId(path)));
      } else
        return Container();
    } else
      return Container();
  }

  Widget LinkWidget(TextEditingController linkTextController, PostType type) {
    if (type == PostType.YOUTUBE || type == PostType.LINK) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: linkTextController,
          decoration: InputDecoration(
            labelText: 'Link',
          ),
          onChanged: (value) {
            print("link $value");

            setState(() {
              this._filePath = value;
            });

            Provider.of<NewPostProvider>(context, listen: false).setpath(value);
          },
        ),
      );
    } else {
      return Container();
    }
  }
}
