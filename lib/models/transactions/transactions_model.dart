import 'package:hive/hive.dart';
import 'package:personal_money_management_app/models/category/category_model.dart';
part 'transactions_model.g.dart';

@HiveType(typeId: 3)
class TransactionsModel {
  @HiveField(0)
  final String purpose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime dateTime;
  @HiveField(3)
  final CategoryType categoryType;
  @HiveField(4)
  final CategoryModel categoryModel;
  @HiveField(5)
  String? id;

  TransactionsModel(
      {required this.purpose,
      required this.amount,
      required this.dateTime,
      required this.categoryType,
      required this.categoryModel}) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
