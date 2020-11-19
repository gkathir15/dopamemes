import 'package:dopamemes/exports/ModelExports.dart';
import 'package:hive/hive.dart';

part 'Posts.g.dart';

@HiveType(typeId: 1)
class Posts {
  @HiveField(0)
  String sId;
  @HiveField(1)
  String caption;
  @HiveField(2)
  CategoryDetails categoryDetails;
  @HiveField(3)
  String categoryId;
  @HiveField(4)
  int createdAt;
  @HiveField(5)
  String fileUrl;
  @HiveField(6)
  String isMature;
  @HiveField(7)
  OwnerDetails ownerDetails;
  @HiveField(8)
  String ownerId;
  @HiveField(9)
  String postType;
  @HiveField(10)
  double updatedAt;
  @HiveField(11)
  bool is_liked;
  @HiveField(12)
  int likes_count;


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
      this.updatedAt,
      this.is_liked,
      this.likes_count});

  bool checkIfMature() {
    if (isMature == null) return false;
    return isMature == "true";
  }

  Posts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    caption = json['caption'];
    categoryDetails = json['category_details'] != null
        ? new CategoryDetails.fromJson(json['category_details'])
        : null;
    categoryId = json['category_id'];
    createdAt = (json['created_at'].toInt());
    fileUrl = json['file_url'];
    isMature = json['is_mature'].toString();
    ownerDetails = json['owner_details'] != null
        ? new OwnerDetails.fromJson(json['owner_details'])
        : null;
    ownerId = json['owner_id'];
    postType = json['post_type'];
    updatedAt = json['updated_at'];
    is_liked = json['is_liked'];
    likes_count = json['likes_count'];
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
    data['is_liked'] = this.is_liked;
    data['likes_count'] = this.likes_count;
    return data;
  }
}
