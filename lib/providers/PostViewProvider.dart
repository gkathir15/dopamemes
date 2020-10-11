import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/model/PostsResponse.dart';
import 'package:flutter/foundation.dart';

import 'Conts.dart';

class PostProvider with ChangeNotifier {
  Future<List<Posts>> postsData;
  List<Posts> _pData = List();
  String lastId = "";

  Future<List<Posts>> getFilteredList(Categories categoryDetails) async {
    if (categoryDetails.sId == "0")
      return postsData;
    else {
      var _data = await postsData;
      return _data
          .where((element) => element.categoryId == categoryDetails.sId)
          .toList();
    }
  }

  fetchPosts() async {
    Response response = await Dio().get(Conts.baseUrl + "api/v1/posts");
    print(response.toString());
    PostsResponse postsResponse =
        PostsResponse.fromJson(json.decode(response.toString()));
    print(postsResponse.data.posts.length);
    _pData.addAll(pumpAds(postsResponse.data.posts));
    // _pData.add(Posts(postType: "ad"));
    postsData = allPostsFuture();
    notifyListeners();
  }

  List<Posts> allPosts() => _pData;

  Future<List<Posts>> allPostsFuture() async {
    return _pData;
  }

  List<Posts> pumpAds(List<Posts> list) {
    if (list.length > 9) {
      list.insert(5, Posts(sId: "0", postType: "ad"));
    }
    return list;
  }

  paginatePosts(Posts lastPost) async {
    print(lastPost.toJson().toString());
    var url = Conts.baseUrl + "api/v1/posts?lastId=${lastPost.sId}";
    print(url);
    Response response = await Dio().get(url);
    print(response.toString());
    PostsResponse postsResponse =
        PostsResponse.fromJson(json.decode(response.toString()));
    print(postsResponse.data.posts.length);
    _pData.addAll(pumpAds(postsResponse.data.posts));
    // _pData.add(Posts(postType: "ad"));
    postsData = allPostsFuture();
    notifyListeners();
  }

  ///dummy profiel id 5f4bf11b4eece7b043c8cc29

  addNewUploadedPost(Posts posts) {
    _pData.insert(0, posts);
    postsData = allPostsFuture();
  }
}
