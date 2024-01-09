import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_1/model/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CrudManager with ChangeNotifier {
  final List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  // JSON keys
  static const String _tasksKey = 'tasks';

  CrudManager() {
    // Load tasks from SharedPreferences when the class is instantiated
    _loadTasks();
  }

  void _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedTasksJson = prefs.getStringList(_tasksKey);

    if (storedTasksJson != null) {
      _tasks.clear();
      _tasks.addAll(storedTasksJson.map((jsonString) {
        return TaskModel.fromJson(jsonDecode(jsonString));
      }));
      notifyListeners();
    }
  }

  void _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasksJson =
        _tasks.map((task) => jsonEncode(task.toJson())).toList();
    prefs.setStringList(_tasksKey, tasksJson);
  }

  void addToTasks(TaskModel task) {
    _tasks.add(task);
    _saveTasks();
    notifyListeners();
  }

  void removeFromTasks(TaskModel task) {
    _tasks.remove(task);
    _saveTasks();
    notifyListeners();
  }

  void taskDone(TaskModel task) {
    task.isDone = !task.isDone;
    _saveTasks();
    notifyListeners();
  }

  void updateTask(TaskModel oldTask, TaskModel newTask) {
    // Find the index of the old task in the list
    int index = _tasks.indexOf(oldTask);

    // Replace the old task with the new task
    if (index != -1) {
      _tasks[index] = newTask;
      _saveTasks(); // Save the updated list to SharedPreferences
      notifyListeners();
    }
  }
}
