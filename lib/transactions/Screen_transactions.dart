import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management_application/DataBase/category/category_db.dart';
import 'package:money_management_application/DataBase/transactions/transactions_db.dart';
import 'package:money_management_application/models/categories/category_model.dart';
import 'package:money_management_application/models/transactions/transaction_model.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionsDb.instance.refresh();
    CategoryDb.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionsDb.instance.transactionListNotifier,
      builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
        return ListView.separated(
          padding: const EdgeInsets.all(10),



          itemBuilder: (ctx, index) {
            final _value = newList[index];
            return Slidable(
              key: Key(_value.id!),
              startActionPane: ActionPane(
                motion: DrawerMotion(),
               children: [
                SlidableAction(onPressed: (ctx){
                  TransactionsDb.instance.deleteTransactions(_value.id!);
                },
                icon: Icons.delete_outline,
                label: 'Delete',
                )
               ]),
              child: Card(
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    maxRadius: 50,
                    child: Text(
                      parseDate(_value.date),
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: _value.type == CategoryType.income
                        ? Color.fromARGB(255, 139, 220, 92)
                        : Color.fromARGB(255, 139, 147, 255),
                  ),
                  title: Text('RS ${_value.amount}'),
                  subtitle: Text(_value.category.name),
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return const SizedBox(height: 8);
          },
          itemCount: newList.length,
        );
      },
    );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splittedDate = _date.split(' ');
    return '${_splittedDate.last}\n${_splittedDate.first}';
  }
}
