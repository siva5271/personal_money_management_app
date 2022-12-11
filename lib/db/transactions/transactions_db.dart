import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:personal_money_management_app/models/transactions/transactions_model.dart';

const String TRANSACTIONS_DB = 'transactions_db';

abstract class TransactionsDBFunctions {
  Future<void> addTransactions(TransactionsModel newTransaction);
  Future<void> getTransactions();
  Future<void> deleteTransactions(String key);
}

class TransactionsDB implements TransactionsDBFunctions {
  ValueNotifier<List<TransactionsModel>> transactionsNotifier =
      ValueNotifier([]);
  TransactionsDB._internal();
  static TransactionsDB instance = TransactionsDB._internal();
  factory TransactionsDB() {
    return instance;
  }

  @override
  Future<void> addTransactions(TransactionsModel newTransaction) async {
    final _db = await Hive.openBox<TransactionsModel>(TRANSACTIONS_DB);
    await _db.put(newTransaction.id, newTransaction);
    getTransactions();
  }

  @override
  Future<void> getTransactions() async {
    final _db = await Hive.openBox<TransactionsModel>(TRANSACTIONS_DB);
    transactionsNotifier.value.clear();
    transactionsNotifier.value.addAll(_db.values);
    transactionsNotifier.value
        .sort((first, second) => second.dateTime.compareTo(first.dateTime));

    transactionsNotifier.notifyListeners();
  }

  @override
  Future<void> deleteTransactions(String key) async {
    final _db = await Hive.openBox<TransactionsModel>(TRANSACTIONS_DB);
    await _db.delete(key);
    getTransactions();
  }
}
