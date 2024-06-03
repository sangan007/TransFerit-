import 'package:flutter/material.dart';
import 'package:money_management_application/models/categories/category_model.dart';

import '../../DataBase/category/category_db.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb().incomeCategoryListListener,
      builder: (BuildContext ctx, List<CategoryModel> newList, Widget?_) {
        return ListView.separated(
          itemBuilder: (ctx, index) {
            final category = newList[index];
            return Card(
              child: ListTile(
                title: Text(category.name),
                trailing: IconButton(
                  onPressed: () {
                   CategoryDb.instance.deleteCategory(category.id);
                  },
                  icon:const Icon(Icons.delete, color: Colors.red),
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return const SizedBox(height: 10);
          },
          itemCount: newList.length,
        );
      },
    );
  }
}