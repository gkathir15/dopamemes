import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:dopamemes/model/PostsResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'Conts.dart';

class PostProvider with ChangeNotifier {

  String lastId = "";
  Box<Posts> postsHiveBox;

  ScrollController scrollController;

  PostProvider() {
    print("PostsInit");
    //  Hive.registerAdapter(PostsAdapter());
    openHiveBox();
    scrollController = ScrollController();
  }

  Future<List<Posts>> getFilteredList(Categories categoryDetails) async {
    var data = postsHiveBox.values.distinctBy((element) => element.sId);
    data.sort((a, b) => a.createdAt.toInt().compareTo(b.createdAt.toInt()));

    if (data.isEmpty) {
      fetchPosts();
    }
    if (categoryDetails.sId == "0") {
      data = postsHiveBox.values.distinctBy((element) => element.sId);
    data.distinctBy((element) => element.sId);
      data.toList();
    } else {
      data = postsHiveBox.values
          .toList()
          .distinctBy((element) => element.sId);
      data.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      data.toList();
    }

    return data;
  }

  animateToTopOfList() {
    scrollController.animateTo(0,
        duration: Duration(seconds: 5), curve: Curves.easeOutQuad);
  }

  fetchPosts() async {
    Response response = await Dio().get(Conts.baseUrl + "api/v1/posts");
    print(response.toString());
    PostsResponse postsResponse =
        PostsResponse.fromJson(json.decode(response.toString()));
    print(postsResponse.data.posts.length);
    postsHiveBox.addAll(postsResponse.data.posts);

    notifyListeners();
  }

  fetchRecent(String firstId) async {
    Response response =
        await Dio().get(Conts.baseUrl + "api/v1/posts?firstId=$firstId");
    print(response.toString());
    PostsResponse postsResponse =
        PostsResponse.fromJson(json.decode(response.toString()));
    print(postsResponse.data.posts.length);
    postsHiveBox.addAll(postsResponse.data.posts);
    notifyListeners();
  }





  List<Posts> pumpAds(List<Posts> list) {
    if (list.length > 9) {
      list.insert(5, Posts(sId: "0", postType: "ad"));
      //   list.insert(0, Posts(sId: "0", postType: "vidList"));
    }
    return list;
  }

  paginatePosts() async {
    var data = postsHiveBox.values.distinctBy((element) => element.sId);
    data.sort((a, b) => a.createdAt.toInt().compareTo(b.createdAt.toInt()));
    print(data.last.toJson().toString());
    var url = Conts.baseUrl + "api/v1/posts?lastId=${data.last.sId}";
    print(url);
    Response response = await Dio().get(url);
    print(response.toString());
    PostsResponse postsResponse =
        PostsResponse.fromJson(json.decode(response.toString()));
    print(postsResponse.data.posts.length);
    postsHiveBox.addAll(postsResponse.data.posts);
    notifyListeners();
  }

  ///dummy profiel id 5f4bf11b4eece7b043c8cc29

  addNewUploadedPost(Posts posts) {
    var data = postsHiveBox.values.distinctBy((element) => element.sId);
    data.sort((a, b) => a.createdAt.toInt().compareTo(b.createdAt.toInt()));
    fetchRecent(data.first.sId);
  }

  openHiveBox() async {
    postsHiveBox = Hive.box<Posts>("POSTS");
  }

  sharePost(Posts posts) {}
}
