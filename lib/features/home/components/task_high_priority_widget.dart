import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projects/features/home/home_controller.dart';
import 'package:projects/models/task_model.dart';
import 'package:projects/features/tasks/high_priority_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme_controller.dart';
import '../../../core/widgets/custom_check_box.dart';

class TaskHighPriorityWidget extends StatelessWidget {
  const TaskHighPriorityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, HomeController controller, Widget? child) {
        final tasksList = controller.tasks;
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
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
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'High Priority Tasks',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff15B86C),
                        ),
                      ),
                    ),
                    tasksList.reversed
                                .where((e) => e.isHighPriority)
                                .toList()
                                .length ==
                            0
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "There are no high priority tasks right now 🙁",
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium!.copyWith(fontSize: 14.0),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                tasksList.reversed
                                        .where((e) => e.isHighPriority)
                                        .toList()
                                        .length >
                                    4
                                ? 4
                                : tasksList.reversed
                                      .where((e) => e.isHighPriority)
                                      .toList()
                                      .length,
                            itemBuilder: (context, index) {
                              final task = tasksList.reversed
                                  .where((e) => e.isHighPriority)
                                  .toList()[index];
                              return Row(
                                children: [
                                  CustomCheckBox(
                                    value: task.isDone,
                                    onChanged: (bool? value) {
                                      final index = tasksList.indexWhere(
                                        (e) => e.id == task.id,
                                      );
                                      controller.doneTasks(value, index);
                                    },
                                  ),
                                  SizedBox(width: 4.0),
                                  Expanded(
                                    child: Text(
                                      task.taskName,

                                      style: task.isDone
                                          ? Theme.of(
                                              context,
                                            ).textTheme.titleLarge
                                          : Theme.of(
                                              context,
                                            ).textTheme.titleMedium,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),

                    /// another way to retrieve data
                    // ...tasks.reversed.where((e) => e.isHighPriority).take(4).map((
                    //   element,
                    // ) {
                    //   return Row(
                    //     children: [
                    //       Checkbox(
                    //         value: element.isDone,
                    //         activeColor: Color(0xff15B86C),
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadiusGeometry.circular(4.0),
                    //         ),
                    //         onChanged: (bool? value) {
                    //           final index = tasks.indexWhere(
                    //             (e) => e.id == element.id,
                    //           );
                    //           onTap(value, index);
                    //         },
                    //       ),
                    //       SizedBox(width: 4.0),
                    //       Expanded(
                    //         child: Text(
                    //           element.taskName,
                    //
                    //           style: TextStyle(
                    //             color: element.isDone
                    //                 ? Color(0xffA0A0A0)
                    //                 : Color(0xffFFFCFC),
                    //             fontSize: 16.0,
                    //             decoration: element.isDone
                    //                 ? TextDecoration.lineThrough
                    //                 : TextDecoration.none,
                    //             decorationColor: Color(0xffA0A0A0),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   );
                    // }),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HighPriorityScreen()),
                  );

                  if (result == true) {
                    controller.loadTask();
                  }
                },
                child: Container(
                  width: 56,
                  height: 48,
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ThemeController.isDark()
                          ? Color(0xff6E6E6E)
                          : Color(0xffD1DAD6),
                    ),
                  ),
                  child: SvgPicture.asset(
                    "assets/images/arrow_up_right.svg",
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(
                      ThemeController.isDark()
                          ? Color(0xffC6C6C6)
                          : Color(0xff3A4640),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
