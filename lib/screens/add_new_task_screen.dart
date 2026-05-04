import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projects/core/services/preferences_manager.dart';
import 'package:projects/core/widgets/custom_elevated_button.dart';
import 'package:projects/core/widgets/custom_text_form_field.dart';
import 'package:projects/models/task_model.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool isHighPriority = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color(0xffFFFCFC),
        title: Text(
          "Add New Task",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            right: 16.0,
            left: 16.0,
            bottom: 16.0,
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
                        hintText: 'e.g. Finish UI design for login screen',
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
                        hintText:
                            'e.g. Finish onboarding UI and hand off to devs by Thursday.',
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
                // ElevatedButton(
                //   onPressed: () async {
                //     _key.currentState?.validate();
                //
                //     final pref = await SharedPreferences.getInstance();
                //     final taskJson = pref.getString("tasks");
                //     List<dynamic> listTasks = [];
                //
                //     if (taskJson != null) {
                //       listTasks = jsonDecode(taskJson);
                //     }
                //     final TaskModel taskModel = TaskModel(
                //       id: listTasks.length + 1,
                //       taskName: taskNameController.text,
                //       taskDescription: taskDescriptionController.text,
                //       isHighPriority: isHighPriority,
                //     );
                //
                //     print('listTasks before added $listTasks');
                //     listTasks.add(taskModel.toJson());
                //     print('listTasks after added $listTasks');
                //     final taskEncode = jsonEncode(listTasks);
                //     await pref.setString("tasks", taskEncode);
                //
                //     Navigator.of(context).pop(true);
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Color(0xff15B86C),
                //     foregroundColor: Color(0xffFFFCFC),
                //     fixedSize: Size(MediaQuery.of(context).size.width, 40.0),
                //   ),
                //   child: Text(
                //     'Add Task',
                //     style: TextStyle(
                //       fontSize: 16.0,
                //       fontWeight: FontWeight.w500,
                //       color: Color(0xffFFFCFC),
                //     ),
                //   ),
                // ),
                CustomElevatedButton(
                  title: 'Add Task',
                  height: 40.0,
                  width: MediaQuery.of(context).size.width,
                  onPressed: () async {
                    if (!(_key.currentState?.validate() ?? false)) return;

                    final taskJson = PreferencesManager().getString('tasks');
                    List<dynamic> listTasks = [];

                    if (taskJson != null) {
                      listTasks = jsonDecode(taskJson);
                    }

                    final TaskModel taskModel = TaskModel(
                      id: listTasks.length + 1,
                      taskName: taskNameController.text,
                      taskDescription: taskDescriptionController.text,
                      isHighPriority: isHighPriority,
                    );

                    listTasks.add(taskModel.toJson());

                    final taskEncode = jsonEncode(listTasks);
                    await PreferencesManager().setString('tasks',taskEncode);
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
