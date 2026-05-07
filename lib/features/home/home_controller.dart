import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projects/models/task_model.dart';
import '../../core/constants/storage_key.dart';
import '../../core/services/preferences_manager.dart';

class HomeController with ChangeNotifier {
  List<TaskModel> taskList = [];
  String username = "Guest";
  bool isLoading = false;
  String? userImagePath;
  List<TaskModel> tasks = [];
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percent = 0;

  void init() {
    loadUsername();
    loadTask();
  }

  void loadUsername() async {

    username = PreferencesManager().getString(StorageKey.username) ?? "Guest";
    userImagePath = PreferencesManager().getString(StorageKey.userImage);

    notifyListeners();
  }

  void loadTask() async {

    isLoading = true;

    final finalTask = PreferencesManager().getString(StorageKey.tasks);

    if (finalTask != null && finalTask.isNotEmpty) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();

      calculatePercent();
    }


    isLoading = false;

    notifyListeners();
  }

  deleteTask(int? id) async {
    if (id == null) return;

    tasks.removeWhere((tasks) => tasks.id == id);
    calculatePercent();

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    await PreferencesManager().setString(
      StorageKey.tasks,
      jsonEncode(updatedTask),
    );

    notifyListeners();
  }

  calculatePercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((e) => e.isDone).length;
    percent = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;

    notifyListeners();
  }

  doneTasks(bool? value, int? index) async {
    tasks[index!].isDone = value ?? false;
    calculatePercent();

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    await PreferencesManager().setString(
      StorageKey.tasks,
      jsonEncode(updatedTask),
    );

    notifyListeners();
  }
}
