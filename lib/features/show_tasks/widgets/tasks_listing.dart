import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_assignment/features/show_tasks/cubit/show_task_cubit.dart';
import 'package:todo_assignment/features/show_tasks/widgets/priority_tasks.dart';
import 'package:todo_assignment/utils/common/common_color.dart';
import 'package:todo_assignment/utils/common/common_const.dart';
import 'package:todo_assignment/utils/common/common_utils.dart';
import 'package:todo_assignment/utils/common/models/task_model.dart';
import 'package:todo_assignment/utils/common/widgets/custom_space.dart';
import 'package:todo_assignment/utils/common/widgets/custom_text.dart';

Widget tasksListing(
  BuildContext context,
  Size size,
  ShowTasksCubit cubitData,
  List<TaskModel> tasks,
  List<TaskModel> urgentPriorityTasks,
  List<TaskModel> mediumPriorityTasks,
  List<TaskModel> leastPriorityTasks,
) {
  if (tasks.isEmpty) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset('${CommonPath.aniamtionPath}no_data.json'),
        CustomText(
          title: 'Add some tasks!',
          fontSize: size.width * numD045,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  } else {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * numD035),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(size.width * numD03),

            ///
            priorityTasks(
              context,
              size,
              cubitData,
              'Urgent Priority',
              CommonColor.errorColor,
              urgentPriorityTasks,
            ),

            ///
            verticalSpace(size.width * numD03),
            priorityTasks(
              context,
              size,
              cubitData,
              'Medium Priority',
              CommonColor.blueColor,
              mediumPriorityTasks,
            ),

            ///
            verticalSpace(size.width * numD03),

            priorityTasks(
              context,
              size,
              cubitData,
              'Least Priority',
              CommonColor.successColor,
              leastPriorityTasks,
            ),
            verticalSpace(size.width * numD20),
          ],
        ),
      ),
    );
  }
}
