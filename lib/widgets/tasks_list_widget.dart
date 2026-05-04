import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projects/widgets/task_item_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/widgets/custom_check_box.dart';
import '../models/task_model.dart';

class TasksListWidget extends StatelessWidget {
  const TasksListWidget({
    super.key,
    required this.onTap,
    required this.tasks,
    required this.emptyWarningMessage,
    required this.onDelete,
    required this.onEdit,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function(int?) onDelete;
  final Function onEdit;
  final String emptyWarningMessage;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(
            child: Text(
              emptyWarningMessage,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: tasks.length,
            padding: EdgeInsets.only(bottom: 16),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TaskItemWidget(
                  model: tasks[index],
                  onChanged: (bool? value) {
                    onTap(value, index);
                  },
                  onDelete: (int id) {
                    onDelete(id);
                  }, onEdit: (){
                    onEdit();
                },
                ),
              );
            },
          );
  }
}
