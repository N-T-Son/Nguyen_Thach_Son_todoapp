import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  String currentDate = DateFormat.yMMMd().format(DateTime.now());
  List<String> categories = ["Khẩn cấp", "Quan trọng", "Thấp"];
  List<Todo> allTodos = [
    
  ];

  List<Todo> get deletedTodos {
    return allTodos.where((element) => element.toBeDeleted).toList();
  }

  List<Todo> get completedTodos {
    return allTodos
        .where((element) => element.isComplete && !element.toBeDeleted)
        .toList();
  }

  void addTodo(String title, String description, String date, String time,
      String category) {
    allTodos.add(Todo(
        title: title,
        date: date,
        description: description,
        time: time,
        category: category));
    notifyListeners();
  }

  void toggleToBeDeleted(Todo todo) {
    todo.toBeDeleted = !todo.toBeDeleted;
    notifyListeners();
  }

  void toggleIsComplete(Todo todo) {
    todo.isComplete = !todo.isComplete;
    notifyListeners();
  }

  List<Todo> getSearchResults(String task) {
    return allTodos
        .where((element) =>
            RegExp(task, caseSensitive: false).hasMatch(element.title))
        .toList();
  }

  void addCategory(String category) {
    categories.add(category);
    notifyListeners();
  }

  void removeCategory(String category) {
    categories.remove(category);
    notifyListeners();
  }
}
