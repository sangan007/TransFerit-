import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_application/models/categories/category_model.dart';
import 'package:money_management_application/models/transactions/transaction_model.dart';
import 'package:money_management_application/screens/add_transaction/Screen_add_transaction.dart';
import 'package:money_management_application/screens/screen_home.dart';
import 'package:money_management_application/transactions/Screen_transactions.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Hive.initFlutter();

if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)){
  Hive.registerAdapter(CategoryTypeAdapter());
 }

 if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)){
  Hive.registerAdapter(CategoryModelAdapter());
 }

 if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)){
  Hive.registerAdapter(TransactionModelAdapter());
 }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        floatingActionButtonTheme:FloatingActionButtonThemeData(
          backgroundColor:  Color.fromARGB(255, 147, 230, 92), 
          foregroundColor: Color.fromARGB(255, 2, 0, 43),

        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 147, 230, 92)),
        scaffoldBackgroundColor: Color.fromARGB(255, 2, 0, 43),
        useMaterial3: true,
      ),
      home:  ScreenHome(),
      routes: {
        ScreenAddTransaction.routeName:(ctx) => const ScreenAddTransaction(),
      },
    );
  }
}


