class UserDataRequest {
  String name;
  String imageUrl;
  String email;
  int age;
  String uid;

  UserDataRequest({this.name, this.imageUrl, this.email, this.age, this.uid});

  UserDataRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageUrl = json['imageUrl'];
    email = json['email'];
    age = json['age'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['email'] = this.email;
    data['age'] = this.age;
    data['uid'] = this.uid;
    return data;
  }
}
