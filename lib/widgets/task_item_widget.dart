import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projects/core/theme/theme_controller.dart';
import 'package:projects/models/task_model.dart';

import '../core/enums/task_item_actions_enum.dart';
import '../core/services/preferences_manager.dart';
import '../core/widgets/custom_check_box.dart';
import '../core/widgets/custom_elevated_button.dart';
import '../core/widgets/custom_text_form_field.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });

  final TaskModel model;
  final Function(bool?) onChanged;
  final Function(int) onDelete;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: double.infinity,
      // alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: ThemeController.isDark()
              ? Colors.transparent
              : Color(0xffD1DAD6),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 8.0),
          CustomCheckBox(
            value: model.isDone,
            onChanged: (bool? value) => onChanged(value),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.taskName,

                  style: model.isDone
                      ? Theme.of(context).textTheme.titleLarge
                      : Theme.of(
                          context,
                        ).textTheme.titleMedium!.copyWith(fontSize: 16.0),
                ),
                if (model.taskDescription.isNotEmpty)
                  Text(
                    model.taskDescription,
                    style: model.isDone
                        ? Theme.of(
                            context,
                          ).textTheme.titleLarge!.copyWith(fontSize: 14.0)
                        : Theme.of(
                            context,
                          ).textTheme.titleSmall!.copyWith(fontSize: 14.0),
                  ),
              ],
            ),
          ),
          PopupMenuButton<TaskItemActionsEnum>(
            icon: Icon(Icons.more_vert),
            onSelected: (value) async {
              switch (value) {
                case TaskItemActionsEnum.edit:
                  final result = await _showButtonSheet(context, model);
                  if(result == true){
                    onEdit();
                  }
                case TaskItemActionsEnum.delete:
                  await _showAlertDialog(context);
                case TaskItemActionsEnum.markAsDone:
                  onChanged(!model.isDone);
              }
            },
            itemBuilder: (context) => TaskItemActionsEnum.values.map((e) {
              return PopupMenuItem(value: e, child: Text(e.name));
            }).toList(),
          ),
        ],
      ),
    );
  }

  _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Task'),
          content: Text('Are you sure you want to delete this task'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onDelete(model.id);
                Navigator.pop(context);
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showButtonSheet(BuildContext context, TaskModel model) {
    final TextEditingController taskNameController = TextEditingController();
    final TextEditingController taskDescriptionController =
        TextEditingController();
    final GlobalKey<FormState> _key = GlobalKey<FormState>();
    bool isHighPriority = false;

    return showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFormField(
                            controller: taskNameController,
                            title: 'Task Name',
                            hintText: model.taskName,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Task name is required";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20.0),
                          CustomTextFormField(
                            controller: taskDescriptionController,
                            title: 'Task Description',
                            maxLines: 5,
                            hintText: model.taskDescription,
                            textColor: ThemeController.isDark()
                                ? Colors.white
                                : Colors.black,
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "High Priority",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              Switch(
                                value: isHighPriority,
                                onChanged: (bool value) {
                                  setState(() {
                                    isHighPriority = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    CustomElevatedButton(
                      title: 'Edit Task',
                      height: 40.0,
                      width: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        if (!(_key.currentState?.validate() ?? false)) return;

                        final taskJson = PreferencesManager().getString('tasks');
                        List<dynamic> listTasks = [];

                        if (taskJson != null) {
                          listTasks = jsonDecode(taskJson);
                        }

                        final TaskModel newModel = TaskModel(
                          id: model.id,
                          taskName: taskNameController.text,
                          taskDescription: taskDescriptionController.text,
                          isHighPriority: isHighPriority,
                          isDone: model.isDone,
                        );

                        final item = listTasks.firstWhere((e)=> e['id'] == model.id);

                        final int index = listTasks.indexOf(item);

                        listTasks[index] = newModel;


                        final taskEncode = jsonEncode(listTasks);
                        await PreferencesManager().setString('tasks', taskEncode);
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
