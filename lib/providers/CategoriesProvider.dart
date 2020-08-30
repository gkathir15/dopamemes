import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:dopamemes/exports/ModelExports.dart';

class CategoriesProvider with ChangeNotifier
{
    List<Categories> categories = List();
    Categories mainCategory = Categories.name("All");
    Categories newCategory = Categories.name("all");

    List<Categories> getAllCategories()
    {
        categories.add(Categories.name("All"));
        return categories;
    }


    setNewPostSelected(int pos)
    {
        newCategory = categories[pos];
    }



}