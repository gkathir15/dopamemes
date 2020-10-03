import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/model/PostsResponse.dart';
import 'package:flutter/foundation.dart';

import 'Conts.dart';

class PostProvider with ChangeNotifier {
  Future<List<Posts>> postsData;
  List<Posts> _pData = List();
  String lastId = "";

  fetchPosts() async {
    Response response = await Dio().get(Conts.baseUrl + "api/v1/posts");
    print(response.toString());
    PostsResponse postsResponse =
        PostsResponse.fromJson(json.decode(response.toString()));
    print(postsResponse.data.posts.length);
    _pData.addAll(postsResponse.data.posts);
    // _pData.add(Posts(postType: "ad"));
    postsData = allPostsFuture();
    notifyListeners();
  }

  List<Posts> allPosts() => _pData;

  Future<List<Posts>> allPostsFuture() async {
    return _pData;
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
    _pData.addAll(postsResponse.data.posts);
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
