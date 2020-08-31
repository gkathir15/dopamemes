import 'package:dopamemes/exports/ModelExports.dart';
class CategoriesResponse {
  Data data;
  bool success;

  CategoriesResponse({this.data, this.success});

  CategoriesResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  List<Categories> catagories;

  Data({this.catagories});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['catagories'] != null) {
      catagories = new List<Categories>();
      json['catagories'].forEach((v) {
        catagories.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.catagories != null) {
      data['catagories'] = this.catagories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


