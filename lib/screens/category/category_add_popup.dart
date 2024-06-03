import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_management_application/DataBase/category/category_db.dart';
import 'package:money_management_application/models/categories/category_model.dart';

ValueNotifier<CategoryType> SelectedCategoryNotifier =
            ValueNotifier(CategoryType.income);

Future <void> showCategoryaddpopup(BuildContext context) async{
  final  _nameEditingController = TextEditingController();
  showDialog(context: context,
   builder: (ctx){
    return SimpleDialog(
    backgroundColor:  Color.fromARGB(255, 147, 230, 92),
      title: const Text('add category'),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _nameEditingController,
            decoration: const InputDecoration(
              hintText: 'category name' ,
              hintStyle: TextStyle(color:  Color.fromARGB(255, 2, 0, 43)),
              border: OutlineInputBorder(
              ),
            ),
          ),
        ),
        Padding(padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              RadioButton(title: 'income', type: CategoryType.income,),
              RadioButton(title: 'expense', type: CategoryType.expense),
            ],
          ),
         ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: (){
              final _name = _nameEditingController.text;
              if (_name.isEmpty){
                return;
              }
              final _type =SelectedCategoryNotifier.value;
              final _category = CategoryModel(
                id: DateTime.now().microsecondsSinceEpoch.toString(), 
               name: _name,
               type: _type,);
              CategoryDb.instance.insertCategory(_category);
              Navigator.of(ctx).pop();
            },
           child: const Text('add'),
           ),
        ),
      ],
    );
   },
   );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
   RadioButton({
    required this.title,
    required this.type,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(valueListenable: SelectedCategoryNotifier,
         builder: (BuildContext ctx, CategoryType newCategory, Widget? _categorydb){
          return Radio<CategoryType>(
          value: type,
         groupValue: SelectedCategoryNotifier.value,
          onChanged: (value){
            if (value == null){
              return;
            }
           SelectedCategoryNotifier.value= value;
           SelectedCategoryNotifier.notifyListeners();
          },
          );
         }),
        Text(title),
      ],
    );
  }
}