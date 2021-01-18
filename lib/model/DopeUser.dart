import 'package:hive/hive.dart';

part 'DopeUser.g.dart';

@HiveType(typeId:6)
class DopeUser {
  @HiveField(0)
  String sId;
  @HiveField(1)
  int age;
  @HiveField(2)
  double createdAt;
  @HiveField(3)
  String displayName;
  @HiveField(4)
  String email;
  @HiveField(5)
  String imageUrl;
  @HiveField(6)
  String uid ="";
  @HiveField(7)
  double updatedAt;
  @HiveField(9)
  bool isLoggedIn = false;


  String getUid()
  {
   return uid!=null?uid:" ";
  }



  DopeUser(
      {this.sId,
      this.age,
      this.createdAt,
      this.displayName,
      this.email,
      this.imageUrl,
      this.uid,
      this.updatedAt});

  DopeUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    age = json['age'];
    createdAt = json['created_at'];
    displayName = json['display_name'];
    email = json['email'];
    imageUrl = json['image_url'];
    uid = json['uid'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['age'] = this.age;
    data['created_at'] = this.createdAt;
    data['display_name'] = this.displayName;
    data['email'] = this.email;
    data['image_url'] = this.imageUrl;
    data['uid'] = this.uid;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
