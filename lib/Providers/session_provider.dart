import "package:flutter/material.dart";
import "dart:math" as math;

class SessionProvider with ChangeNotifier {
  int selectedCategoryIndex = 0;
  List<Todo> todos = [
    Todo(0, "item 1", 0),
    Todo(1, "item 2", 0),
    Todo(2, "item 3", 0),
    Todo(3, "item 4", 1),
    Todo(4, "item 5", 1),
    Todo(5, "item 6", 2),
    Todo(6, "item 7", 2),
    Todo(7, "item 8", 2),
    Todo(8, "item 9", 3),
    Todo(9, "item 10", 3),
    Todo(10, "item 11", 3),
    Todo(11, "item 12", 4),
    Todo(12, "item 13", 4),
    Todo(13, "item 14", 3),
    Todo(14, "item 15", 2),
    Todo(15, "item 16", 1),
    Todo(16, "item 17", 0),
  ];

  List<Category> categories = [
    Category("Important", const Color(0xffff4405)),
    Category("Next Week", const Color(0xffffb405)),
    Category("Work", const Color(0xff6d05ff)),
    Category("Chores", const Color(0xffff058a)),
    Category("Personal Care", const Color(0xff00e817)),
    Category("General", const Color(0xff3305ff)),
    Category("All", const Color(0xff05ffb8)),
  ];

  void check(int index) {
    todos[index].check();
    notifyListeners();
  }

  void remove(int index) {
    todos.removeWhere((element) => element.id == index);
    notifyListeners();
  }

  void add(String name, int catid) {
    if (name == "") return;
    todos.add(Todo(todos.length, name, catid));
    notifyListeners();
  }

  void changeCategory(int index) {
    selectedCategoryIndex = index;
    notifyListeners();
  }

  List<Todo> filteredItem() {
    if (selectedCategoryIndex == categories.length - 1) {
      return todos;
    }
    return todos
        .where((element) => element.catid == selectedCategoryIndex)
        .toList();
  }
}

class Todo {
  late int _id;
  late String _name;
  late bool _isChecked;
  late int _catid;

  Todo(int id, String name, int catid) {
    _id = id;
    _name = name;
    _catid = catid;
    _isChecked = false;
  }

  bool check() => _isChecked = !_isChecked;

  int get id => _id;
  String get name => _name;
  bool get isChecked => _isChecked;
  int get catid => _catid;
}

class Category {
  late String _name;
  late Color _color;

  Color get color => _color;
  String get name => _name;

  Category(name, color) {
    _name = name;
    _color = color;
  }
}
