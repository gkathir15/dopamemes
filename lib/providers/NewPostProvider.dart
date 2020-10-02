import 'package:dio/dio.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class NewPostProvider with ChangeNotifier {
  PostProvider _postsProvider;

  NewPostProvider(this._postsProvider);

  UploadStatus _uploadStatus = UploadStatus.NONE;

  UploadStatus status() {
    return _uploadStatus;
  }

  String path;

  setpath(String pat) {
    path = pat;
    notifyListeners();
  }

  newYoutubePost(Map formData) {
    updateUploadStatus(UploadStatus.UPLOADING);

    Dio()
        .post(Conts.baseUrl + "api/v1/posts/youtube", data: formData)
        .then((value) => null)
        .then((value) {
      print(value);
      updateUploadStatus(UploadStatus.DONE);
    }).catchError((error) {
      print(error);
      updateUploadStatus(UploadStatus.FAILED);
    });
  }

  newFilePostUpload(FormData formData) {
    updateUploadStatus(UploadStatus.UPLOADING);
    Dio()
        .post(Conts.baseUrl + "api/v1/posts", data: formData)
        .then((value) => null)
        .then((value) {
      print(value);
      updateUploadStatus(UploadStatus.DONE);
    }).catchError((error) {
      print(error);
      updateUploadStatus(UploadStatus.FAILED);
    });
  }

  updateUploadStatus(UploadStatus uploadStatus) {
    _uploadStatus = uploadStatus;
    notifyListeners();
  }
}

enum UploadStatus { NONE, UPLOADING, DONE, FAILED }
