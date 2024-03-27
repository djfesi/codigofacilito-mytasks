import 'package:MyTask/data/services/services.dart';
import 'package:MyTask/domain/entity/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  final DbService dbService;

  TaskProvider({required this.dbService}) {
    loadTasks();
  }

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    final results = await dbService.tasksQuery('myTasks');
    if (results != null) {
      _tasks = results
          .map((task) => Task(
                id: task['id'],
                title: task['title'],
                description: task['description'],
                createdAt:
                    DateTime.fromMillisecondsSinceEpoch(task['created_at']),
              ))
          .toList();
      notifyListeners();
    }
  }

  Future<bool> addTask(Task task) async {
    final id = await dbService.taskInsert('myTasks', {
      'title': task.title,
      'description': task.description,
    });
    if (id != null) {
      final newTask = Task(
          id: id,
          title: task.title,
          description: task.description,
          createdAt: DateTime.now());
      _tasks.add(newTask);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> updateTask(Task task) async {
    final result = await dbService.taskUpdate(
      'myTasks',
      values: {'title': task.title, 'description': task.description},
      where: 'id = ?',
      whereArgs: [task.id],
    );
    if (result > 0) {
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = task;
        notifyListeners();
      }
      return true;
    }
    return false;
  }

  Future<void> deleteTask(int id) async {
    await dbService.taskDelete('myTasks', where: 'id = ?', whereArgs: [id]);
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }
}
