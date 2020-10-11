import 'package:hive/hive.dart';

part 'OwnerDetails.g.dart';
@HiveType(typeId: 2)
class OwnerDetails {
  @HiveField(0)
  String sId;
  @HiveField(1)
  String displayName;
  @HiveField(3)
  String imageUrl;

  OwnerDetails({this.sId, this.displayName, this.imageUrl});

  OwnerDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    displayName = json['display_name'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['display_name'] = this.displayName;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
