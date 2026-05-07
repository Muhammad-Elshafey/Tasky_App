import 'package:flutter/material.dart';
import 'package:projects/core/components/task_item_widget.dart';
import 'package:projects/features/home/home_controller.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/custom_check_box.dart';
import '../../../models/task_model.dart';

class SliverTasksListWidget extends StatelessWidget {
  const SliverTasksListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder:
          (BuildContext context, HomeController controller, Widget? child) {
            final taskList = controller.tasks;
            return controller.isLoading
                ? SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  )
                : taskList.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'No Data',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: EdgeInsetsGeometry.only(bottom: 50.0),
                    sliver: SliverList.builder(
                      itemCount: taskList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: TaskItemWidget(
                            model: taskList[index],
                            onChanged: (bool? value) {
                              controller.doneTasks(value, index);
                            },
                            onDelete: (int id) {
                              controller.deleteTask(id);
                            },
                            onEdit: () => controller.loadTask(),
                          ),
                        );
                      },
                    ),
                  );
          },
    );
  }
}
