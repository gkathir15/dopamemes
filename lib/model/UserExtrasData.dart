class UserExtrasData {
  String id;
  String collection;
  Permissions permissions;
  String userID;
  String email;
  String dispName;
  String profileImage;
  int age;
  int updatedAt;

  UserExtrasData(
      {this.id,
        this.collection,
        this.permissions,
        this.userID,
        this.email,
        this.dispName,
        this.profileImage,
        this.age,
        this.updatedAt});

  UserExtrasData.fromJson(Map<String, dynamic> json) {
    id = json['\$id'];
    collection = json['\$collection'];
    permissions = json['\$permissions'] != null
        ? new Permissions.fromJson(json['\$permissions'])
        : null;
    userID = json['userID'];
    email = json['email'];
    dispName = json['dispName'];
    profileImage = json['profileImage'];
    age = json['age'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$id'] = this.id;
    data['\$collection'] = this.collection;
    if (this.permissions != null) {
      data['\$permissions'] = this.permissions.toJson();
    }
    data['userID'] = this.userID;
    data['email'] = this.email;
    data['dispName'] = this.dispName;
    data['profileImage'] = this.profileImage;
    data['age'] = this.age;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Permissions {
  List<String> read;
  List<String> write;

  Permissions({this.read, this.write});

  Permissions.fromJson(Map<String, dynamic> json) {
    read = json['read'].cast<String>();
    write = json['write'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['read'] = this.read;
    data['write'] = this.write;
    return data;
  }
}