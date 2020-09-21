class YoutubeUploadReq {
  String caption;
  String ownerId;
  String categoryId;
  String youtubeUrl;
  bool isMature;

  YoutubeUploadReq(
      {this.caption,
        this.ownerId,
        this.categoryId,
        this.youtubeUrl,
        this.isMature});

  YoutubeUploadReq.fromJson(Map<String, dynamic> json) {
    caption = json['caption'];
    ownerId = json['ownerId'];
    categoryId = json['categoryId'];
    youtubeUrl = json['youtubeUrl'];
    isMature = json['isMature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['caption'] = this.caption;
    data['ownerId'] = this.ownerId;
    data['categoryId'] = this.categoryId;
    data['youtubeUrl'] = this.youtubeUrl;
    data['isMature'] = this.isMature;
    return data;
  }
}
