class CategoryDetails {
  String sId;
  String displayIcon;
  String displayName;

  CategoryDetails({this.sId, this.displayIcon, this.displayName});

  CategoryDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    displayIcon = json['display_icon'];
    displayName = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['display_icon'] = this.displayIcon;
    data['display_name'] = this.displayName;
    return data;
  }
}
