import 'package:dio/dio.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:dopamemes/model/CategoriesResponse.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:dopamemes/exports/ModelExports.dart';

class CategoriesProvider with ChangeNotifier {
  List<Categories> categories = List();
  Categories mainCategory = Categories(sId: "0", displayName: "All");
  Categories newPostUploadCategory;

  // CategoriesProvider(this._postProvider, this._newPostProv);

  fetchCategories() async {
    Response response = await Dio().get(Conts.baseUrl + "api/v1/categories");
    print(response.toString());
    CategoriesResponse categoriesResponse =
        CategoriesResponse.fromJson(json.decode(response.toString()));
    print(categoriesResponse.data.catagories.length);
    categories.addAll(categoriesResponse.data.catagories);
    notifyListeners();

    newPostUploadCategory = categories[0];
  }

  setNewPostSelected(int pos) {
    newPostUploadCategory = categories[pos];
  }

  List<Categories> allCategories() => categories.toSet().toList();

  setMainCategory(Categories selectedCategory) {
    mainCategory = selectedCategory;
    notifyListeners();
  }
}
