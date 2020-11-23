import 'package:dio/dio.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:dopamemes/model/CategoriesResponse.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:dopamemes/exports/ModelExports.dart';
import 'package:hive/hive.dart';
import 'package:flutter_extentions/iterable.dart';

class CategoriesProvider with ChangeNotifier {
  Categories _feedSelectedCategory = Categories(sId: "0", displayName: "All");
  Categories _newPostUploadCategory;

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

  Categories getFeedCategory()
  {
    if(_feedSelectedCategory!=null){
      return _feedSelectedCategory;
    }
    else{
      _feedSelectedCategory = categoriesHiveBox.values.distinctBy((element) => element.sId)[0];
      return _feedSelectedCategory;
    }
  }



  fetchCategories() async {
    Response response = await Dio().get(Conts.baseUrl + "api/v1/categories");
    print(response.toString());
    CategoriesResponse categoriesResponse =
        CategoriesResponse.fromJson(json.decode(response.toString()));
    print(categoriesResponse.data.catagories.length);
    if(categoriesResponse.data.catagories.isNotEmpty)
      {
      await   categoriesHiveBox.clear();
      }
    categoriesHiveBox.addAll(categoriesResponse.data.catagories);
    _newPostUploadCategory = categoriesHiveBox.values.distinctBy((element) => element.sId)[0];
    notifyListeners();
  }

  setNewPostSelected(int pos) {
    _newPostUploadCategory =  categoriesHiveBox.values.distinctBy((element) => element.sId)[pos];
  }

  getNewPostsSelectedCategory()
  {
    if(_newPostUploadCategory!=null){
      return _newPostUploadCategory;
    }
    else{
      _newPostUploadCategory = categoriesHiveBox.values.distinctBy((element) => element.sId)[0];
      return _newPostUploadCategory;
    }

  }

  List<Categories> allCategories() => categoriesHiveBox.values.distinctBy((e) =>e.sId);

  setMainCategory(Categories selectedCategory) {
    _feedSelectedCategory = selectedCategory;
    notifyListeners();
  }
}
