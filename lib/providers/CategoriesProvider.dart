import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:dopamemes/exports/ProviderExports.dart';
import 'package:dopamemes/model/CategoriesResponse.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:dopamemes/exports/ModelExports.dart';

class CategoriesProvider with ChangeNotifier
{
    List<Categories> categories = List();
    Categories mainCategory;
    Categories newCategory;






    fetchCategories() async
    {
        Response response = await  Dio().get(Consts.baseUrl+"api/v1/catagories");
        print(response.toString());
       CategoriesResponse categoriesResponse = CategoriesResponse.fromJson(json.decode(response.toString()));
       print(categoriesResponse.data.catagories.length);
       categories.addAll(categoriesResponse.data.catagories);
       notifyListeners();
    }


    setNewPostSelected(int pos)
    {
        newCategory = categories[pos];
    }

    List<Categories> allCategories() => categories.toSet().toList();






}