import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:personal_money_management_app/db/transactions/transactions_db.dart';
import 'package:personal_money_management_app/models/category/category_model.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionsDB.instance.getTransactions();
    return ValueListenableBuilder(
        valueListenable: TransactionsDB.instance.transactionsNotifier,
        builder: ((context, transaction, _) => ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: ((context, index) {
              return Slidable(
                  key: Key(transaction[index].id!),
                  startActionPane:
                      ActionPane(motion: const ScrollMotion(), children: [
                    SlidableAction(
                      onPressed: (context) => TransactionsDB()
                          .deleteTransactions(transaction[index].id!),
                      icon: Icons.delete,
                      label: 'Delete',
                    )
                  ]),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(DateFormat.MMMd()
                            .format(transaction[index].dateTime)),
                        radius: 30,
                        backgroundColor: transaction[index].categoryType ==
                                CategoryType.income
                            ? Colors.green
                            : Colors.red,
                      ),
                      title: Text(transaction[index].amount.toString()),
                      subtitle: Text(transaction[index].categoryModel.name),
                    ),
                  ));
            }),
            separatorBuilder: ((context, index) => const SizedBox(
                  height: 20,
                )),
            itemCount: transaction.length)));
  }
}
