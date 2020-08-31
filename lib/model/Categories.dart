class Categories {
  String sId;
  double createdAt;
  String displayIcon;
  String displayName;
  bool isMature;
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