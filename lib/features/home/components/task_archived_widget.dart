import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/theme/theme_controller.dart';

class TaskArchivedWidget extends StatelessWidget {
  const TaskArchivedWidget({super.key, required this.totalTasks, required this.totalDoneTasks, required this.percent});


  final int totalTasks ;
  final int totalDoneTasks;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Achieved Tasks",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 4),
              Text(
                "$totalDoneTasks Out of $totalTasks Done",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          Stack(
            alignment: AlignmentGeometry.center,
            children: [
              SizedBox(
                width: 48.0,
                height: 48.0,
                child: Transform.rotate(
                  angle: -pi / 2,
                  child: CircularProgressIndicator(
                    backgroundColor: Color(0xff9E9E9E),
                    value: percent,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xff15B86C),
                    ),
                    strokeWidth: 4.0,
                  ),
                ),
              ),
              Text(
                "${(percent * 100).toInt()}%",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
