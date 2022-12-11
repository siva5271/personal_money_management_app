import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:personal_money_management_app/db/category/category_db.dart';

class IncomeList extends StatelessWidget {
  const IncomeList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDb().incomeListNotifier,
        builder: ((context1, newList, _) {
          return ListView.separated(
              itemBuilder: ((ctx, index) => Card(
                    child: ListTile(
                      title: Text(newList[index].name),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: (() async => await CategoryDb()
                            .deleteCategory(newList[index].id)),
                      ),
                    ),
                  )),
              separatorBuilder: ((context, index) => const SizedBox(
                    height: 10,
                  )),
              itemCount: newList.length);
        }));
  }
}
