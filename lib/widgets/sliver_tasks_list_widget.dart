import 'package:flutter/material.dart';
import 'package:projects/widgets/task_item_widget.dart';
import '../core/widgets/custom_check_box.dart';
import '../models/task_model.dart';

class SliverTasksListWidget extends StatelessWidget {
  const SliverTasksListWidget({
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
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                emptyWarningMessage,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          )
        : SliverPadding(
            padding: EdgeInsetsGeometry.only(bottom: 50.0),
            sliver: SliverList.builder(
              itemCount: tasks.length,
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
                    },
                    onEdit: () => onEdit(),
                  ),
                );
              },
            ),
          );
  }
}
