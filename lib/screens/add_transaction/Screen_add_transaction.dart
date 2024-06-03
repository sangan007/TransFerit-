import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_management_application/DataBase/category/category_db.dart';
import 'package:money_management_application/DataBase/transactions/transactions_db.dart';
import 'package:money_management_application/models/categories/category_model.dart';
import 'package:money_management_application/models/transactions/transaction_model.dart';

class ScreenAddTransaction extends StatefulWidget {
  static const routeName ='add_transaction';

  const ScreenAddTransaction ({super.key});

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}


class _ScreenAddTransactionState extends State<ScreenAddTransaction> {

DateTime? _selectDate;
CategoryType? _selectedCategoryType;
CategoryModel? _selectedCategoryModel;
 String? _categoryID;

 final _purposeEditingController = TextEditingController();
 final _amountEditingController = TextEditingController();

@override
  void initState() {
  _selectedCategoryType =CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 0, 43),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _purposeEditingController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Purpose',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 147, 230, 92)),
                ),
                 style: TextStyle(color:  Color.fromARGB(255, 147, 230, 92)),
              ),
              TextFormField(
                controller: _amountEditingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Amount',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 147, 230, 92)),
                ),
                style: TextStyle(color:  Color.fromARGB(255, 147, 230, 92)),
              ),
               TextButton.icon(
                onPressed: () async{
                 final _selectDateTemp = await  showDatePicker(
                    context: context,
                   firstDate: DateTime.now().subtract(Duration(days:30)),
                    lastDate: DateTime.now() ,
                    );
                    if(_selectDateTemp == null){
                      return;
                    }
                    else {
                      print(_selectDate.toString());
                      setState(() {
                        _selectDate = _selectDateTemp;
                      });
                    }
                },
                icon: Icon(Icons.calendar_today,color:   Color.fromARGB(255, 147, 230, 92),),
               label: Text( _selectDate == null
              ? 'Select Date'
              : _selectDate!.toString()
              ),
               ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.income, 
                        groupValue:_selectedCategoryType,
                         onChanged: (newValue){
                          setState(() {
                            _selectedCategoryType = CategoryType.income;
                            _categoryID = null; 
                          });
                         
                         },
                         ),
                         Text('Income',
                         style: TextStyle(color:   Color.fromARGB(255, 147, 230, 92)),
                         ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.expense, 
                        groupValue: _selectedCategoryType,
                         onChanged: (newValue){
                          setState(() {
                          _selectedCategoryType = CategoryType.expense; 
                           _categoryID = null;
                          });
                         },
                         ),
                         Text('Expense',
                         style: TextStyle(color:   Color.fromARGB(255, 147, 230, 92)),
                         ),   
                    ],
                  ),
                ],
              ),
              DropdownButton(
                hint: const Text(
                  'Select Category',
                style: TextStyle(color:   Color.fromARGB(255, 147, 230, 92)),),
                value: _categoryID,
                items:(_selectedCategoryType == CategoryType.income
                ?CategoryDb().incomeCategoryListListener: CategoryDb.instance.expenseCategoryListListener)
                .value
                .map((e){
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                    onTap: (){
                      _selectedCategoryModel =e;
                    },
                  );
                }).toList(),
               onChanged: (selectedValue){
                print(selectedValue);
                setState(() {
                  _categoryID = selectedValue;
                });
               },
               style: TextStyle( color:  Color.fromARGB(255, 147, 230, 92)),
               onTap: (){},
               ),
               ElevatedButton.icon(
                onPressed: (){
                  addTransaction();
                },
               icon: Icon(
                Icons.add,
                color:   Color.fromARGB(255, 147, 230, 92) ,
               ) ,
                label: Text('Add'),
                style: ElevatedButton.styleFrom(
                backgroundColor:  Color.fromARGB(255, 255, 255, 255)
                ),
                ),
                
            ],
          ),
        ),
        ),
    );
  }
  Future <void> addTransaction() async{
    final _purposeText = _purposeEditingController.text;
    final _amountText = _amountEditingController.text;
    if (_purposeText.isEmpty){
      return;
    }
    if(_amountText.isEmpty){
      return;
    }
    if (_categoryID == null){
      return;
    }
    if ( _selectDate == null){
      return;
    }
    if (_selectedCategoryModel == null){
      return;
    }
   final _parsedAmount = double.tryParse(_amountText);
    if (_parsedAmount == null){
      return;
    }

   final _model = TransactionModel(
      purpose: _purposeText,
    amount: _parsedAmount,
    date: _selectDate!,
    type: _selectedCategoryType!,
    category: _selectedCategoryModel!,
    );
    TransactionsDb.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransactionsDb.instance.refresh();
  }
}