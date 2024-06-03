import 'package:flutter/material.dart';
import 'package:money_management_application/screens/screen_home.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: ScreenHome.SelectedIndexNotifier, 
    builder: (BuildContext ctx, int updatedIndex, Widget? _){
    return BottomNavigationBar(
    currentIndex: updatedIndex,
    selectedItemColor: Color.fromARGB(255, 147, 230, 92),
    unselectedItemColor:  Color.fromARGB(255, 2, 0, 43),
    onTap: (newIndex){
      ScreenHome.SelectedIndexNotifier.value= newIndex;
    },
      items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.attach_money_outlined),
        label: 'Transactions'),
      BottomNavigationBarItem(
        icon: Icon(Icons.category_outlined),
        label: 'category'),

    ],
    );
    }
    );
  }
}