import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:dio/dio.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/exports/WidgetExports.dart';
import 'package:dopamemes/jam_icons_icons.dart';
import 'package:dopamemes/pages/CategoriesFullScreenDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dopamemes/PostType.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dopamemes/exports/ProviderExports.dart';


class NewPostDialog extends StatefulWidget {
  final PostType postType;
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
  TextEditingController linkTextController;
  ValueNotifier<bool> _isNFSW = ValueNotifier(false);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Mature content",style: GoogleFonts.roboto(fontSize: 20),),
                ValueListenableBuilder(
                  valueListenable: _isNFSW,
                  builder: (_, bool isChecked, __) {
                    return Switch(
                      value: isChecked,
                      onChanged: (state) {
                        _isNFSW.value = state;
                      },
                    );
                  },
                ),
              ],
            ),
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Select Category"),
                  Row(
                    children: [
                      Text(
                          Provider.of<CategoriesProvider>(context, listen: true)
                              .getNewPostsSelectedCategory()
                              .displayName),
                      Icon(JamIcons.chevron_down)
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
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text("Continue",style: GoogleFonts.roboto(fontSize: 20),),
              ),
            )
          ],
        ),
      ),
    );
  }

  youtubeUpload() {
    var map = Map<String, String>();
    map["caption"] = titleTextController.text;
    map["ownerId"] = Provider.of<AccountsProvider>(context,listen: false).getUserExtras().sId;
    map["categoryId"] = Provider.of<CategoriesProvider>(context)
        .getNewPostsSelectedCategory()
        .sId;
    map["youtubeUrl"] = _filePath;
    Provider.of<NewPostProvider>(context, listen: false).newYoutubePost(map, Provider.of<AccountsProvider>(context,listen: false).getUserExtras().getUid());
  }

  fileUploadUpload() async {
    FormData formData;
    var map = Map<String, dynamic>();
    map["caption"] = titleTextController.text;
    map["ownerId"] =  Provider.of<AccountsProvider>(context,listen: false).getUserExtras().sId;
    map["categoryId"] = Provider.of<CategoriesProvider>(context,listen: false)
        .getNewPostsSelectedCategory()
        .sId;
    map["file"] = await MultipartFile.fromFile(_filePath);
    map["postType"] = _postType
        .toString()
        .split(".")[1]
        .toLowerCase(); //splitting from PostType.IMAGE to image
    formData = FormData.fromMap(map);
    Provider.of<NewPostProvider>(context, listen: false)
        .newFilePostUpload(formData, Provider.of<AccountsProvider>(context,listen: false).getUserExtras().getUid());
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
    linkTextController?.dispose();
  }

  Widget fromPath(String path, PostType type) {
    var size = MediaQuery.of(context).size;
    if (_filePath != null) {
      if (type == PostType.IMAGE) {
        return SizedBox(child: Image.file(File(path)), width: size.width,
          height: size.height / 3);
      } else if (type == PostType.VIDEO) {
        
        return SizedBox(
          child: VideoPostWidget(Posts(fileUrl: path)),
          width: size.width,
          height: size.height / 3,
        );
      } else if (type == PostType.YOUTUBE && path != null) {
        return YtPostWidget(Posts(fileUrl: path));
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
