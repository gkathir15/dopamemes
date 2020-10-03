import 'package:dopamemes/exports/ModelExports.dart';
class NewPostResponse {
  Data data;
  String message;
  bool success;

  NewPostResponse({this.data, this.message, this.success});

  NewPostResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  Posts post;

  Data({this.post});

  Data.fromJson(Map<String, dynamic> json) {
    post = json['post'] != null ? new Posts.fromJson(json['post']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.post != null) {
      data['post'] = this.post.toJson();
    }
    return data;
  }
}






