import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import '../../core/services/preferences_manager.dart';
import '../../models/task_model.dart';
import '../../core/components/tasks_list_widget.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  List<TaskModel> highPriorityTasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _loadTask();
  }

  _deleteTask(int? id) async {
    List<TaskModel> tasks = [];
    if (id == null) return;

    final finalTask = PreferencesManager().getString("tasks");

    if (finalTask != null && finalTask.isNotEmpty) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();
      tasks.removeWhere((e) => e.id == id);

      setState(() {
        highPriorityTasks.removeWhere((task) => task.id == id);
      });

      final updatedTask = tasks.map((element) => element.toJson()).toList();
      await PreferencesManager().setString('tasks', jsonEncode(updatedTask));
    }
  }

  void _loadTask() async {
    setState(() {
      isLoading = true;
    });
    // await Future.delayed(Duration(
    //   seconds: 5,
    // ));

    final finalTask = PreferencesManager().getString("tasks");

    if (finalTask != null && finalTask.isNotEmpty) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
        highPriorityTasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .where((element) => element.isHighPriority)
            .toList();

        highPriorityTasks = highPriorityTasks.reversed.toList();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        title: Text(
          "High Priority Tasks",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Color(0xffFFFCFC),
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.white))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: TasksListWidget(
                tasks: highPriorityTasks,
                emptyWarningMessage: "No Tasks Found",
                onTap: (value, index) async {
                  setState(() {
                    highPriorityTasks[index!].isDone = value ?? false;
                  });

                  final allData = PreferencesManager().getString("tasks");

                  if (allData != null) {
                    List<TaskModel> allDataList = (jsonDecode(allData) as List)
                        .map((element) => TaskModel.fromJson(element))
                        .toList();
                    final int newIndex = allDataList.indexWhere(
                      (e) => e.id == highPriorityTasks[index!].id,
                    );
                    allDataList[newIndex] = highPriorityTasks[index!];
                    await PreferencesManager().setString(
                      "tasks",
                      jsonEncode(allDataList),
                    );

                    _loadTask();
                  }
                },
                onDelete: (int? id) {
                  _deleteTask(id);
                }, onEdit: (){
                  _loadTask();
              },
              ),
            ),
    );
  }
}
