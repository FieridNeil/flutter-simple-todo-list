import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:todo_flutter/Providers/session_provider.dart';

class CategoryDrawerMenu extends StatelessWidget {
  const CategoryDrawerMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.white,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SizedBox(
              height: 160,
              child: Container(
                  padding: const EdgeInsets.only(top: 90),
                  color: Colors.blue,
                  child: const Text(
                    "Categories",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ))),
          SizedBox(
            height: 700,
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: context.read<SessionProvider>().categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                            color: context
                                .read<SessionProvider>()
                                .categories[index]
                                .color,
                            width: 10),
                      ),
                    ),
                    child: Text(
                        context.read<SessionProvider>().categories[index].name,
                        style: const TextStyle(fontSize: 20)),
                  ),
                  onTap: () {
                    context.read<SessionProvider>().changeCategory(index);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ]));
  }
}
