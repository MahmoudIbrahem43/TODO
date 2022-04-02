import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_todo_app/db/db_helper.dart';
import 'package:my_todo_app/models/task.dart';

class TaskController extends GetxController {
  final RxList<Task> taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) {
    print (' add task controller function is called');
    return DBHelper.insert(task!);
  }

 Future<void> getTasks() async {
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
      print (' add task controller function is called');
    taskList.assignAll(tasks.map((date) => Task.fromJson(date)).toList());
  }

  void deleteTask(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }

  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }
}
