import 'package:dopamemes/exports/ModelExports.dart';

class Posts {
  String sId;
  String caption;
  CategoryDetails categoryDetails;
  String categoryId;
  double createdAt;
  String fileUrl;
  String isMature;
  OwnerDetails ownerDetails;
  String ownerId;
  String postType;
  double updatedAt;

  Posts(
      {this.sId,
      this.caption,
      this.categoryDetails,
      this.categoryId,
      this.createdAt,
      this.fileUrl,
      this.isMature,
      this.ownerDetails,
      this.ownerId,
      this.postType,
      this.updatedAt});

  Posts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    caption = json['caption'];
    categoryDetails = json['category_details'] != null
        ? new CategoryDetails.fromJson(json['category_details'])
        : null;
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    fileUrl = json['file_url'];
    isMature = json['is_mature'].toString();
    ownerDetails = json['owner_details'] != null
        ? new OwnerDetails.fromJson(json['owner_details'])
        : null;
    ownerId = json['owner_id'];
    postType = json['post_type'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['caption'] = this.caption;
    if (this.categoryDetails != null) {
      data['category_details'] = this.categoryDetails.toJson();
    }
    data['category_id'] = this.categoryId;
    data['created_at'] = this.createdAt;
    data['file_url'] = this.fileUrl;
    data['is_mature'] = this.isMature;
    if (this.ownerDetails != null) {
      data['owner_details'] = this.ownerDetails.toJson();
    }
    data['owner_id'] = this.ownerId;
    data['post_type'] = this.postType;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
