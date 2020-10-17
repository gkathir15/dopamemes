import 'package:dio/dio.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:dopamemes/model/CategoriesResponse.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:hive/hive.dart';

class CategoriesProvider with ChangeNotifier {
  List<Categories> categories = List();
  Categories mainCategory = Categories(sId: "0", displayName: "All");
  Categories newPostUploadCategory;

  // CategoriesProvider(this._postProvider, this._newPostProv);

  Box<Categories> categoriesHiveBox;

  CategoriesProvider() {
    print("CategoriesInit");
   // Hive.registerAdapter(CategoriesAdapter());
    openHiveBox();
  }

  openHiveBox() async {
    categoriesHiveBox =  Hive.box<Categories>("CATEGORIES");
  }

  fetchCategories() async {
    Response response = await Dio().get(Conts.baseUrl + "api/v1/categories");
    print(response.toString());
    CategoriesResponse categoriesResponse =
        CategoriesResponse.fromJson(json.decode(response.toString()));
    print(categoriesResponse.data.catagories.length);
    categoriesHiveBox.addAll(categoriesResponse.data.catagories);
    categories = categoriesHiveBox.values.toList();
    newPostUploadCategory = categories[0];
    notifyListeners();
  }

  setNewPostSelected(int pos) {
    newPostUploadCategory = categories[pos];
  }

  List<Categories> allCategories() => categoriesHiveBox.values.toList();

  setMainCategory(Categories selectedCategory) {
    mainCategory = selectedCategory;
    notifyListeners();
  }
}
