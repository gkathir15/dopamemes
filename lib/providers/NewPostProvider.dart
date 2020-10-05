import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class NewPostProvider with ChangeNotifier {
 // PostProvider _postsProvider;

  final Queue<Posts> _uploadedQueue = new Queue();

//  NewPostProvider(this._postsProvider);

  addtoQueue(Posts posts) {
    _uploadedQueue.add(posts);
    notifyListeners();
  }

  Posts pollQueue() {
    var post = _uploadedQueue.first;
    _uploadedQueue.clear();
    return post;
  }

  UploadStatus _uploadStatus = UploadStatus.NONE;

  UploadStatus status() {
    return _uploadStatus;
  }

  String path;

  setpath(String pat) {
    path = pat;
    notifyListeners();
  }

  newYoutubePost(Map formData) async {
    updateUploadStatus(UploadStatus.UPLOADING);

   Response response = await  Dio().post(Conts.baseUrl + "api/v1/posts/youtube", data: formData);
    updateUploadStatus(UploadStatus.DONE);
    NewPostResponse newPostResponse =
        NewPostResponse.fromJson(json.decode(response.toString()));
    addtoQueue(newPostResponse.data.post);
    updateUploadStatus(UploadStatus.UPDATED);


  }

  newFilePostUpload(FormData formData) async {
    updateUploadStatus(UploadStatus.UPLOADING);
    Response response =
        await Dio().post(Conts.baseUrl + "api/v1/posts", data: formData);
    updateUploadStatus(UploadStatus.DONE);
    NewPostResponse newPostResponse =
        NewPostResponse.fromJson(json.decode(response.toString()));
    addtoQueue(newPostResponse.data.post);
    updateUploadStatus(UploadStatus.UPDATED);
  }

  updateUploadStatus(UploadStatus uploadStatus) {
    _uploadStatus = uploadStatus;
    notifyListeners();
  }
}

enum UploadStatus { NONE, UPLOADING, DONE, FAILED, UPDATED }
