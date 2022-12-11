import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:personal_money_management_app/db/category/category_db.dart';
import 'package:personal_money_management_app/screens/category/income_list.dart';

import 'expense_list.dart';

class CateoryScreen extends StatefulWidget {
  const CateoryScreen({super.key});

  @override
  State<CateoryScreen> createState() => _CateoryScreenState();
}

class _CateoryScreenState extends State<CateoryScreen>
    with SingleTickerProviderStateMixin {
  @override
  late TabController _tabController;

  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDb().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(
                text: 'Income',
              ),
              Tab(
                text: 'Expense',
              )
            ]),
        Expanded(
            child: TabBarView(
                controller: _tabController,
                children: const [IncomeList(), ExpenseList()]))
      ],
    );
  }
}
