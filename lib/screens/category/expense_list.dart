import 'package:flutter/material.dart';

import '../../db/category/category_db.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDb().expenseListNotifier,
        builder: ((ctx, newList, _) {
          return ListView.separated(
              itemBuilder: (ctx, index) => Card(
                    child: ListTile(
                      title: Text(newList[index].name),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async => await CategoryDb()
                            .deleteCategory(newList[index].id),
                      ),
                    ),
                  ),
              separatorBuilder: ((context, index) => const SizedBox(
                    height: 10,
                  )),
              itemCount: newList.length);
        }));
  }
}
