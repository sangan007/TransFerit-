import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management_application/models/categories/category_model.dart';
import 'package:money_management_application/models/transactions/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionsDbFunctions{
 Future <void> addTransaction(TransactionModel obj);
Future <List<TransactionModel>> getAllTransactions();
Future <void> deleteTransactions(String id);
}

class TransactionsDb implements TransactionsDbFunctions{
 TransactionsDb._internal();
static TransactionsDb instance = TransactionsDb._internal();

factory TransactionsDb(){
  return instance;
}

ValueNotifier<List<TransactionModel>>  transactionListNotifier =
  ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async{
  final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
 await _db.put(obj.id, obj);
  }

  Future <void> refresh() async{
    final _list = await getAllTransactions();
    _list.sort((first,second)=>second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();
  }
  
  @override
  Future<List<TransactionModel>> getAllTransactions()async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
   return _db.values.toList();
  }
  
  @override
  Future<void> deleteTransactions(String id) async {
     final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.delete(id);
    refresh();
  }

}