import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:personal_money_management_app/models/category/category_model.dart';

const categoryDBName = 'category_db';

abstract class CategoryDBFunctions {
  Future<void> insertCategory(CategoryModel value);
  Future<List<CategoryModel>> getCategories();
  Future<void> deleteCategory(String value);
}

class CategoryDb implements CategoryDBFunctions {
  CategoryDb.internal();
  ValueNotifier<List<CategoryModel>> incomeListNotifier = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseListNotifier = ValueNotifier([]);
  static CategoryDb instance = CategoryDb.internal();
  factory CategoryDb() {
    return instance;
  }
  Future<void> insertCategory(CategoryModel value) async {
    final category_db = await Hive.openBox<CategoryModel>(categoryDBName);
    await category_db.put(value.id, value);
    refreshUI();
  }

  Future<List<CategoryModel>> getCategories() async {
    final category_db = await Hive.openBox<CategoryModel>(categoryDBName);

    return category_db.values.toList();
  }

  Future<void> refreshUI() async {
    incomeListNotifier.value.clear();
    expenseListNotifier.value.clear();
    List<CategoryModel> newList = await getCategories();
    await Future.forEach(
        newList,
        (element) => {
              if (element.categoryType == CategoryType.income)
                {incomeListNotifier.value.add(element)}
              else
                {expenseListNotifier.value.add(element)}
            });
    incomeListNotifier.notifyListeners();
    expenseListNotifier.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String value) async {
    final category_db = await Hive.openBox<CategoryModel>(categoryDBName);
    await category_db.delete(value);
    refreshUI();
  }
}
