import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projects/models/task_model.dart';
import 'package:projects/screens/add_new_task_screen.dart';
import 'package:projects/widgets/sliver_tasks_list_widget.dart';
import 'package:projects/widgets/task_archived_widget.dart';
import '../core/services/preferences_manager.dart';
import '../core/widgets/custom_svg_image.dart';
import '../widgets/task_high_priority_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "Guest";
  bool isLoading = false;
  String? userImagePath;
  List<TaskModel> tasks = [];
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percent = 0;

  @override
  void initState() {
    super.initState();

    _loadUsername();
    _loadTask();
  }

  Future<void> _loadUsername() async {
    if (!mounted) return;

    setState(() {
      username = PreferencesManager().getString("username") ?? "Guest";
      userImagePath = PreferencesManager().getString("user_image");
    });
  }

  void _loadTask() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    final finalTask = PreferencesManager().getString("tasks");

    if (finalTask != null && finalTask.isNotEmpty) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();

      _calculatePercent();
    }

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
  }

  _deleteTask(int? id) async {
    if (id == null) return;
    setState(() {
      tasks.removeWhere((tasks) => tasks.id == id);
      _calculatePercent();
    });

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    await PreferencesManager().setString('tasks', jsonEncode(updatedTask));
  }

  _calculatePercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((e) => e.isDone).length;
    percent = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
  }

  _doneTasks(bool? value, int? index) async {
    setState(() {
      tasks[index!].isDone = value ?? false;
      _calculatePercent();
    });

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    await PreferencesManager().setString('tasks', jsonEncode(updatedTask));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => ProfileScreen(),
                            //   ),
                            // );
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: userImagePath != null
                                ? FileImage(File(userImagePath!))
                                : null,
                            backgroundColor: Color(0xff15B86C),
                            child: userImagePath == null
                                ? ClipOval(
                              child: SvgPicture.asset(
                                'assets/images/default_avatar.svg',
                              ),
                            )
                                : null,
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Good Evening, $username ",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "One task at a time.One step closer.",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    Text(
                      "Yuhuu ,Your work Is ",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Row(
                      children: [
                        Text(
                          "almost done ! ",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        SvgPicture.asset(
                          "assets/images/waving_hand.svg",
                          width: 32,
                          height: 32,
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    // Achieved Tasks
                    TaskArchivedWidget(
                      totalTasks: totalTasks,
                      totalDoneTasks: totalDoneTasks,
                      percent: percent,
                    ),
                    SizedBox(height: 8),
                    TaskHighPriorityWidget(
                      tasks: tasks,
                      onTap: (value, index) {
                        _doneTasks(value, index);
                      },
                      onRefresh: _loadTask,
                    ),
                    SizedBox(height: 24),
                    Text(
                      'My Tasks',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              isLoading
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    )
                  : SliverTasksListWidget(
                      tasks: tasks,
                      emptyWarningMessage: "No Data",
                      onTap: (bool? value, int? index) {
                        _doneTasks(value, index);
                      },
                      onDelete: (int? id) {
                        _deleteTask(id);
                      }, onEdit: (){
                        _loadTask();
              },
                    ),
            ],
            // child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //

            //   ],
            // ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final bool? result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
          );
          if (result != null && result) {
            _loadTask();
          }
        },
        icon: Icon(Icons.add),
        label: Text("Add New Task"),
      ),
    );
  }
}
