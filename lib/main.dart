import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:personal_money_management_app/models/category/category_model.dart';
import 'package:personal_money_management_app/models/transactions/transactions_model.dart';
import 'package:personal_money_management_app/screens/category/pop_up_category_screen.dart';
import 'package:personal_money_management_app/screens/home/home_screen.dart';
import 'package:personal_money_management_app/screens/transactions/add_transactions/add_transactions_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionsModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionsModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      routes: {
        AddTransactionsScreen.routeName: (ctx) => const AddTransactionsScreen(),
      },
    );
  }
}
