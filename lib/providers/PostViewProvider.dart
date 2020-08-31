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

  fetchPosts() async {
    Response response = await  Dio().get(Consts.baseUrl+"api/v1/posts");
    print(response.toString());
    PostsResponse postsResponse = PostsResponse.fromJson(json.decode(response.toString()));
    print(postsResponse.data.posts.length);
    _pData.addAll(postsResponse.data.posts);
    postsData = allPostsFuture();
    notifyListeners();
  }

  List<Posts> allPosts() => _pData.toSet().toList();

  Future<List<Posts>> allPostsFuture() async {
    return _pData.toSet().toList();
  }






}
