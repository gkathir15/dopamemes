class DopeUser {
  String sId;
  int age;
  double createdAt;
  String displayName;
  String email;
  String imageUrl;
  String uid;
  double updatedAt;

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