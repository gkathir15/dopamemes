class UserSignupResponse {
  Data data;
  String message;
  bool success;

  UserSignupResponse({this.data, this.message, this.success});

  UserSignupResponse.fromJson(Map<String, dynamic> json) {
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
  User user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  String sId;
  int age;
  double createdAt;
  String displayName;
  String email;
  String imageUrl;
  String uid;
  double updatedAt;

  User(
      {this.sId,
        this.age,
        this.createdAt,
        this.displayName,
        this.email,
        this.imageUrl,
        this.uid,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
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
