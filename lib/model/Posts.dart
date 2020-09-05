import 'package:dopamemes/exports/ModelExports.dart';
class Posts {
  String sId;
  String caption;
  Categories catagoryDetails;
  String catagoryId;
  double createdAt;
  String fileUrl;
  String ownerId;
  String postType;
  double updatedAt;
  DopeUser userDetails;

  Posts(
      {this.sId,
        this.caption,
        this.catagoryDetails,
        this.catagoryId,
        this.createdAt,
        this.fileUrl,
        this.ownerId,
        this.postType,
        this.updatedAt,
        this.userDetails});

  Posts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    caption = json['caption'];
    catagoryDetails = json['catagoryDetails'] != null
        ? new Categories.fromJson(json['catagoryDetails'])
        : null;
    catagoryId = json['catagory_id'];
    createdAt = json['created_at'];
    fileUrl = json['file_url'];
    ownerId = json['owner_id'];
    postType = json['post_type'];
    updatedAt = json['updated_at'];
    userDetails = json['userDetails'] != null
        ? new DopeUser.fromJson(json['userDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['caption'] = this.caption;
    if (this.catagoryDetails != null) {
      data['catagoryDetails'] = this.catagoryDetails.toJson();
    }
    data['catagory_id'] = this.catagoryId;
    data['created_at'] = this.createdAt;
    data['file_url'] = this.fileUrl;
    data['owner_id'] = this.ownerId;
    data['post_type'] = this.postType;
    data['updated_at'] = this.updatedAt;
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails.toJson();
    }
    return data;
  }
}