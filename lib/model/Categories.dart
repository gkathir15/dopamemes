import 'package:hive/hive.dart';

part 'Categories.g.dart';

@HiveType(typeId: 4)
class Categories {
  @HiveField(0)
  String sId;
  @HiveField(1)
  double createdAt;
  @HiveField(2)
  String displayIcon;
  @HiveField(3)
  String displayName;
  @HiveField(4)
  bool isMature;
  @HiveField(5)
  double updatedAt;

  Categories(
      {this.sId,
        this.createdAt,
        this.displayIcon,
        this.displayName,
        this.isMature,
        this.updatedAt});

  Categories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdAt = json['created_at'];
    displayIcon = json['display_icon'];
    displayName = json['display_name'];
    isMature = json['is_mature'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['created_at'] = this.createdAt;
    data['display_icon'] = this.displayIcon;
    data['display_name'] = this.displayName;
    data['is_mature'] = this.isMature;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}