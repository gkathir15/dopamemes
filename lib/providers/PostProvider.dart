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
  int _selectedBottomSheet =0;


  int get selectedBottomSheet => _selectedBottomSheet;

  set selectedBottomSheet(int value) {
    _selectedBottomSheet = value;
    notifyListeners();
  }

  ScrollController scrollController;

  PostProvider() {
    print("PostsInit");
    //  Hive.registerAdapter(PostsAdapter());
    openHiveBox();
    scrollController = ScrollController(keepScrollOffset: true);
  }

  Future<List<Posts>> getFilteredList(Categories categoryDetails) async {
    print("filterCategory"+categoryDetails.displayName);
    var data = postsHiveBox.values.distinctBy((element) => element.sId);

    if (categoryDetails.sId == "0") {
      data = postsHiveBox.values.distinctBy((element) => element.sId);
    } else {
      data = postsHiveBox.values;
          //.where((element) => element.categoryDetails.sId==categoryDetails.sId);
    }
    return data;
  }


  Future<List<Posts>> getList() async {
    return postsHiveBox.values.distinctBy((element) => element.sId);
  }

  animateToTopOfList() {
    if(scrollController.hasClients)
    scrollController.animateTo(0,
        duration: Duration(seconds: 5), curve: Curves.easeOutQuad);
  }

  fetchPosts() async {
    Response response = await Dio().get(Conts.baseUrl + "api/v1/posts");
    print(response.toString());
    PostsResponse postsResponse =
        PostsResponse.fromJson(json.decode(response.toString()));
    print(postsResponse.data.posts.length);
    if(postsResponse.data.posts.isNotEmpty)
      {
        await postsHiveBox.clear();
      }
    postsHiveBox.addAll(postsResponse.data.posts);
  }

  fetchRecent(String firstId) async {
    Response response =
        await Dio().get(Conts.baseUrl + "api/v1/posts?firstId=$firstId");
    print(response.toString());
    PostsResponse postsResponse =
        PostsResponse.fromJson(json.decode(response.toString()));
    print(postsResponse.data.posts.length);
    postsHiveBox.addAll(postsResponse.data.posts);
  }





  List<Posts> pumpAds(List<Posts> list) {
    int interval = 10;
    int adCount=(list.length/interval).toInt();
    print("COUNT $adCount");
    int ct =0;
    while(ct<adCount)
      {
        ++ct;

        var slot = (ct*interval)-3;
        print("slot $slot");
        list.insert(slot, Posts(sId: "$ct", postType: "ad") );
      }
    return list;
  }

  paginatePosts() async {
    var data = postsHiveBox.values.distinctBy((element) => element.sId);
    print(data.last.toJson().toString());
    var url = Conts.baseUrl + "api/v1/posts?lastId=${data.last.sId}";
    print(url);
    Response response = await Dio().get(url);
    print(response.toString());
    PostsResponse postsResponse =
        PostsResponse.fromJson(json.decode(response.toString()));
    print(postsResponse.data.posts.length);
    postsHiveBox.addAll(postsResponse.data.posts);
  }

  ///dummy profile id 5f4bf11b4eece7b043c8cc29

  addNewUploadedPost() {
    var data = postsHiveBox.values.distinctBy((element) => element.sId);
    // data.sort((a, b) => a.createdAt.toInt().compareTo(b.createdAt.toInt()));
    fetchRecent(data.first.sId);
  }

  openHiveBox() async {
    postsHiveBox = Hive.box<Posts>("POSTS");
  }

  sharePost(Posts posts) {}
}
