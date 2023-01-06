import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/Providers/session_provider.dart';
import 'package:todo_flutter/Widgets/new_item_form.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => SessionProvider())],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Todo List',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.blueGrey[50]),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final fieldText = TextEditingController();

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.red;
    }
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    final sessionProvider = context.read<SessionProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text("Awesome Todo List")),
      // drawer: const CategoryDrawerMenu(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height - 150,
        child: Column(
          children: <Widget>[
            CategoryLabel(context, sessionProvider),
            TodoItemsWrapper(context),
            NewItemForm(fieldText: fieldText),
          ],
        ),
      ),
    );
  }

  SizedBox CategoryLabel(
      BuildContext context, SessionProvider sessionProvider) {
    return SizedBox(
      height: 60,
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: sessionProvider
                .categories[sessionProvider.selectedCategoryIndex].color),
        child: TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.white),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                return CategoryDialog(context, sessionProvider);
              },
            );
          },
          child: Center(
            child: Text(
              sessionProvider
                  .categories[sessionProvider.selectedCategoryIndex].name,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }

  AlertDialog CategoryDialog(
      BuildContext context, SessionProvider sessionProvider) {
    return AlertDialog(
      title: const Text(
        "Available Categories",
        style: TextStyle(fontSize: 24),
      ),
      content: Material(
        color: Colors.transparent,
        child: Container(
          height: 400,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: ListView.builder(
            itemCount: context.read<SessionProvider>().categories.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.pop(context);
                  context.read<SessionProvider>().changeCategory(index);
                },
                title: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: sessionProvider.categories[index].color,
                  ),
                  child: Text(
                    context.read<SessionProvider>().categories[index].name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Expanded TodoItemsWrapper(BuildContext context) {
    return Expanded(
      flex: 8,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: ListView.builder(
            itemCount: context.watch<SessionProvider>().filteredItem().length,
            itemBuilder: ((context, index) {
              return Container(
                margin: const EdgeInsets.fromLTRB(15, 6, 15, 6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2.0,
                          spreadRadius: 0.5,
                          offset: Offset(0, 3.0))
                    ]),
                child: TodoItems(context, index),
              );
            })),
      ),
    );
  }

  Row TodoItems(BuildContext context, int index) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ItemCheckBox(context, index),
          ItemName(context, index),
          ItemDeleteIcon(context, index)
        ]);
  }

  Expanded ItemDeleteIcon(BuildContext context, int index) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          context
              .read<SessionProvider>()
              .remove(context.read<SessionProvider>().filteredItem()[index].id);
        },
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: Icon(color: Colors.red, Icons.delete),
        ),
      ),
    );
  }

  Expanded ItemName(BuildContext context, int index) {
    return Expanded(
      flex: 6,
      child: Text(
        context.read<SessionProvider>().filteredItem()[index].name,
        style: TextStyle(
            decoration:
                context.read<SessionProvider>().filteredItem()[index].isChecked
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
      ),
    );
  }

  Expanded ItemCheckBox(BuildContext context, int index) {
    return Expanded(
      child: Checkbox(
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        onChanged: (_) {
          context
              .read<SessionProvider>()
              .check(context.read<SessionProvider>().filteredItem()[index].id);
        },
        value: context.watch<SessionProvider>().filteredItem()[index].isChecked,
      ),
    );
  }
}
