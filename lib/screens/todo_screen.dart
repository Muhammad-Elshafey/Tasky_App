import 'dart:convert';
import 'package:flutter/material.dart';
import '../core/services/preferences_manager.dart';
import '../models/task_model.dart';
import '../widgets/tasks_list_widget.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  bool isLoading = false;
  List<TaskModel> todoTasks = [];

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
        todoTasks.removeWhere((task) => task.id == id);
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
        todoTasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .where((element) => element.isDone == false)
            .toList();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            "To Do Tasks",
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        isLoading
            ? Center(child: CircularProgressIndicator(color: Colors.white))
            : Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TasksListWidget(
                    tasks: todoTasks,
                    emptyWarningMessage: "No Tasks Found",
                    onTap: (value, index) async {
                      setState(() {
                        todoTasks[index!].isDone = value ?? false;
                      });

                      final allData = PreferencesManager().getString("tasks");

                      if (allData != null) {
                        List<TaskModel> allDataList =
                            (jsonDecode(allData) as List)
                                .map((element) => TaskModel.fromJson(element))
                                .toList();
                        final int newIndex = allDataList.indexWhere(
                          (e) => e.id == todoTasks[index!].id,
                        );
                        allDataList[newIndex] = todoTasks[index!];
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
              ),
      ],
    );
  }
}
