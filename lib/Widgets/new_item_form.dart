import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:todo_flutter/Providers/session_provider.dart';

class NewItemForm extends StatelessWidget {
  const NewItemForm({
    Key? key,
    required this.fieldText,
  }) : super(key: key);

  final TextEditingController fieldText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Row(
          children: [
            NewItemInputField(context),
            NewItemAddButton(context),
          ],
        ),
      ),
    );
  }

  Expanded NewItemInputField(BuildContext context) {
    return Expanded(
      flex: 5,
      child: TextField(
        enabled: context.read<SessionProvider>().selectedCategoryIndex ==
                context.read<SessionProvider>().categories.length - 1
            ? false
            : true,
        controller: fieldText,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: "New todo item"),
      ),
    );
  }

  Expanded NewItemAddButton(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.all(10),
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
        ),
        child: GestureDetector(
            onTap: () {
              context.read<SessionProvider>().add(fieldText.text,
                  context.read<SessionProvider>().selectedCategoryIndex);
              fieldText.clear();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: const Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            )),
      ),
    );
  }
}
