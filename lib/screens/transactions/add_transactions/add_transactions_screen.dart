import 'package:flutter/material.dart';
import 'package:personal_money_management_app/db/category/category_db.dart';
import 'package:personal_money_management_app/db/transactions/transactions_db.dart';
import 'package:personal_money_management_app/models/category/category_model.dart';
import 'package:personal_money_management_app/models/transactions/transactions_model.dart';

class AddTransactionsScreen extends StatefulWidget {
  const AddTransactionsScreen({super.key});
  static const routeName = 'add_transaction';

  @override
  State<AddTransactionsScreen> createState() => _AddTransactionsScreenState();
}

class _AddTransactionsScreenState extends State<AddTransactionsScreen> {
  DateTime? _selectedDateTime;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;
  List<CategoryModel>? _selectedList;
  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();
  @override
  void initState() {
    CategoryDb.instance.refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  controller: _purposeTextEditingController,
                  decoration: const InputDecoration(
                      hintText: 'Purpose', border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _amountTextEditingController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Amount', border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton.icon(
                    onPressed: () async {
                      final _selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(const Duration(days: 30)),
                          lastDate: DateTime.now());
                      setState(() {
                        _selectedDateTime = _selectedDate;
                      });
                    },
                    icon: const Icon(Icons.calendar_today),
                    label: Text(_selectedDateTime == null
                        ? "Select Date"
                        : _selectedDateTime.toString())),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        radioButton(CategoryType.income),
                        const Text('Income')
                      ],
                    ),
                    Row(
                      children: [
                        radioButton(CategoryType.expense),
                        const Text('Expense')
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButton(
                    hint: const Text('Select Category'),
                    value: _selectedCategoryModel,
                    items: (_selectedCategoryType == CategoryType.income
                            ? CategoryDb().incomeListNotifier.value
                            : CategoryDb().expenseListNotifier.value)
                        .map((e) {
                      return DropdownMenuItem(
                        child: Text(e.name),
                        value: e,
                      );
                    }).toList(),
                    onChanged: (updatedCategory) {
                      setState(() {
                        _selectedCategoryModel = updatedCategory;
                        print(updatedCategory!.name);
                      });
                    }),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      addToDB();
                    },
                    child: const Text('Submit'))
              ],
            )),
      ),
    );
  }

  Radio<CategoryType> radioButton(CategoryType categoryType) {
    return Radio(
        value: categoryType,
        groupValue:
            _selectedCategoryType == null ? null : _selectedCategoryType,
        onChanged: (updatedCategory) {
          setState(() {
            _selectedCategoryType = updatedCategory;
            _selectedCategoryModel = null;
          });
        });
  }

  Future<void> addToDB() async {
    final _purposetext = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;
    if (_purposetext.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    if (_selectedDateTime == null) {
      return;
    }
    if (_selectedCategoryType == null) {
      return;
    }
    if (_selectedCategoryModel == null) {
      return;
    }
    final _convertedAmountText = double.tryParse(_amountText);
    if (_convertedAmountText == null) {
      return;
    }
    final newTransaction = TransactionsModel(
        purpose: _purposetext,
        amount: _convertedAmountText,
        dateTime: _selectedDateTime!,
        categoryType: _selectedCategoryType!,
        categoryModel: _selectedCategoryModel!);
    TransactionsDB().addTransactions(newTransaction);
    Navigator.pop(context);
  }
}
