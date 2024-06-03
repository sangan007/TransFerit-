import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_management_application/DataBase/category/category_db.dart';
import 'package:money_management_application/screens/add_transaction/Screen_add_transaction.dart';
import 'package:money_management_application/screens/category/Screen_category.dart';
import 'package:money_management_application/models/categories/category_model.dart';
import 'package:money_management_application/screens/category/category_add_popup.dart';
import 'package:money_management_application/screens/widgets/bottomNavigation.dart';
import 'package:money_management_application/transactions/Screen_transactions.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});

  static ValueNotifier<int> SelectedIndexNotifier = ValueNotifier(0);

  final _pages = [
    ScreenTransactions(),
    ScreenCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'TransFerit',
            style: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                color: Color.fromARGB(255, 147, 230, 92),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder<int>(
          valueListenable: SelectedIndexNotifier,
          builder: (BuildContext context, int value, Widget? child) {
            return _pages[value];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (SelectedIndexNotifier.value == 0) {
            print('add transactions');
            Navigator.of(context).pushNamed(ScreenAddTransaction.routeName);
          } else {
            print('add categories');
            showCategoryaddpopup(context);
            // final _sample = CategoryModel(
            //   id: DateTime.now().millisecondsSinceEpoch.toString(),
            //  name: 'Food' ,
            //   type: CategoryType.expense);
            // CategoryDb().insertCategory(_sample);
          }
        },
        child:const Icon(Icons.add),
      ),
    );
  }
}
