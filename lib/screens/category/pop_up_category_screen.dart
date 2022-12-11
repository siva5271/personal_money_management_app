// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:personal_money_management_app/db/category/category_db.dart';

import 'package:personal_money_management_app/models/category/category_model.dart';

ValueNotifier<CategoryType> updatedTypeNotifier =
    ValueNotifier(CategoryType.income);

Future<void> popUpCategoryScreen(BuildContext context) async {
  final TextEditingController _textEditingController = TextEditingController();
  showDialog(
      context: context,
      builder: ((ctx) => SimpleDialog(
            title: const Text('Add Category'),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: "Type the new category here"),
                ),
              ),
              Row(
                children: const [
                  RadioButton(title: 'Income', type: CategoryType.income),
                  RadioButton(title: 'Expense', type: CategoryType.expense)
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    CategoryModel temp = CategoryModel(
                        name: _textEditingController.text,
                        categoryType: updatedTypeNotifier.value,
                        id: DateTime.now().millisecondsSinceEpoch.toString());
                    CategoryDb().insertCategory(temp);
                    Navigator.pop(ctx);
                  },
                  child: const Text('Add'),
                ),
              )
            ],
          )));
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: updatedTypeNotifier,
          builder: ((context, newType, child) {
            return Radio<CategoryType>(
                value: type,
                groupValue: newType,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  updatedTypeNotifier.value = value;
                  updatedTypeNotifier.notifyListeners();
                });
          }),
        ),
        Text(title)
      ],
    );
  }
}
