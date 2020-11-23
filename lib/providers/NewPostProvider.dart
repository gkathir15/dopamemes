
import 'package:dio/dio.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class NewPostProvider with ChangeNotifier {
 // PostProvider _postsProvider;

 // final Queue<Posts> _uploadedQueue = new Queue();





  ValueNotifier<UploadStatus> uploadStatues() {
  return  _uploadStatus;
  }

  set uploadStatus(UploadStatus value) {
    _uploadStatus.value = value;
  }

  ValueNotifier<UploadStatus> _uploadStatus = ValueNotifier(UploadStatus.NONE);

  UploadStatus status() {
    return _uploadStatus.value;
  }

  String path;

  setpath(String pat) {
    path = pat;
    notifyListeners();
  }

  newYoutubePost(Map formData) async {
    updateUploadStatus(UploadStatus.UPLOADING);

   // Response response =
   await  Dio().post(Conts.baseUrl + "api/v1/posts/youtube", data: formData);
    updateUploadStatus(UploadStatus.DONE);
    // NewPostResponse newPostResponse =
    //     NewPostResponse.fromJson(json.decode(response.toString()));

    updateUploadStatus(UploadStatus.UPDATED);


  }

  newFilePostUpload(FormData formData) async {
    updateUploadStatus(UploadStatus.UPLOADING);
    // Response response =
        await Dio().post(Conts.baseUrl + "api/v1/posts", data: formData);
    updateUploadStatus(UploadStatus.DONE);
    // NewPostResponse newPostResponse =
    //     NewPostResponse.fromJson(json.decode(response.toString()));

    updateUploadStatus(UploadStatus.UPDATED);
  }

  updateUploadStatus(UploadStatus uploadStatus) {
    _uploadStatus.value = uploadStatus;
    notifyListeners();
  }
}

enum UploadStatus { NONE, UPLOADING, DONE, FAILED, UPDATED }
