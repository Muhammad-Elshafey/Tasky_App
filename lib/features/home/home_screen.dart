import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projects/features/home/home_controller.dart';
import 'package:projects/features/add_task/add_new_task_screen.dart';
import 'package:projects/features/home/components/sliver_tasks_list_widget.dart';
import 'package:provider/provider.dart';
import 'components/task_archived_widget.dart';
import 'components/task_high_priority_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController()..init(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Selector<HomeController, String?>(
                            selector: (context, controller) =>
                                controller.userImagePath,
                            builder:
                                (
                                  BuildContext context,
                                  String? userImagePath,
                                  Widget? child,
                                ) {
                                  return CircleAvatar(
                                    radius: 20,
                                    backgroundImage: userImagePath != null
                                        ? FileImage(File(userImagePath))
                                        : null,
                                    backgroundColor: Color(0xff15B86C),
                                    child: userImagePath == null
                                        ? ClipOval(
                                            child: SvgPicture.asset(
                                              'assets/images/default_avatar.svg',
                                            ),
                                          )
                                        : null,
                                  );
                                },
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Selector<HomeController, String?>(
                                selector: (context, controller) =>
                                    controller.username,

                                builder:
                                    (
                                      BuildContext context,
                                      String? username,
                                      Widget? child,
                                    ) {
                                      return Text(
                                        "Good Evening, $username ",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium,
                                      );
                                    },
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
                      TaskArchivedWidget(),
                      SizedBox(height: 8),
                      TaskHighPriorityWidget(),
                      SizedBox(height: 24),
                      Text(
                        'My Tasks',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
                SliverTasksListWidget(),
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
        floatingActionButton: Builder(
          builder: (BuildContext context) {
            return FloatingActionButton.extended(
              onPressed: () async {
                final bool? result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
                );
                if (result != null && result) {
                  context.read<HomeController>().loadTask();
                }
              },
              icon: Icon(Icons.add),
              label: Text("Add New Task"),
            );
          },
        ),
      ),
    );
  }
}
