import 'package:dio/dio.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:flutter/foundation.dart';

class NewPostProvider with ChangeNotifier{



  UploadStatus uploadStatus =UploadStatus.NONE;

  String path;

  setpath(String pat)
  {
    path = pat;
    notifyListeners();
  }


  uploadFile(FormData formData)
  {
    uploadStatus = UploadStatus.UPLOADING;
   var resp = Dio().post(Conts.baseUrl+"api/v1/posts/youtube",data: formData).then((value) => null).then((value){
      print(value);
      uploadStatus=UploadStatus.DONE;
    }).catchError((error){
      print(error);
      uploadStatus= UploadStatus.FAILED;
    });



  }

  uploadYoutubeLink()
  {

  }


}

enum UploadStatus{
    NONE,
    UPLOADING,
    DONE,
    FAILED
}