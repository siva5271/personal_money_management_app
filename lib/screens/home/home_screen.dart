import 'package:flutter/material.dart';
import 'package:personal_money_management_app/screens/category/category_screen.dart';
import 'package:personal_money_management_app/screens/category/pop_up_category_screen.dart';
import 'package:personal_money_management_app/screens/home/bottom_navigation.dart';
import 'package:personal_money_management_app/screens/transactions/add_transactions/add_transactions_screen.dart';
import 'package:personal_money_management_app/screens/transactions/transactions_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = const [TransactionsScreen(), CateoryScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Money Manager'),
        centerTitle: true,
      ),
      bottomNavigationBar: const HomeBottomNavigationBar(),
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: selectedIndexNotifier,
              builder: ((context, updatedIndex, child) =>
                  _pages[updatedIndex]))),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (selectedIndexNotifier.value == 0) {
            Navigator.pushNamed(context, AddTransactionsScreen.routeName);
          } else {
            popUpCategoryScreen(context);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
