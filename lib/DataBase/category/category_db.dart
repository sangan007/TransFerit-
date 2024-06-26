import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_application/models/categories/category_model.dart';

const CATEGORY_DB_NAME ='category_database';

abstract class CategorydbFunctions{
  Future <List<CategoryModel>> getCategories();
  Future<void> insertCategory (CategoryModel value);
  Future<void> deleteCategory (String categoryID);
}
class CategoryDb implements CategorydbFunctions { 

  CategoryDb._internal();

  static CategoryDb instance = CategoryDb._internal();
  
  factory CategoryDb (){
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryListListener = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListener = ValueNotifier([]);

   @override
  Future<void> insertCategory(CategoryModel value) async{
   final _categorydb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categorydb.put(value.id,value);
    refreshUI();
  }
  
  @override
  Future<List<CategoryModel>> getCategories() async{
    final _categorydb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categorydb.values.toList();
  }

  Future<void> refreshUI() async{
    final _allCategories = await getCategories();
    incomeCategoryListListener.value.clear();
    expenseCategoryListListener.value.clear();
    await Future.forEach(_allCategories,
     (CategoryModel  category){
      if(category.type == CategoryType.income){
        incomeCategoryListListener.value.add(category);
        }else{
          expenseCategoryListListener.value.add(category);
        }
     });
        incomeCategoryListListener.notifyListeners();
        expenseCategoryListListener.notifyListeners();
  }
  
  @override
  Future<void> deleteCategory(String categoryID)async {
   final _categorydb =await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
  await _categorydb.delete(categoryID);
  refreshUI();
  }

}
